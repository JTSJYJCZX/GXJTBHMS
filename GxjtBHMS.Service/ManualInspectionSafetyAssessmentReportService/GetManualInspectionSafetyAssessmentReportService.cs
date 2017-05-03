using GxjtBHMS.IDAL;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging;
using System.Linq;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Service.Messaging.SecondLevelSafetyAssessmentReport;
using GxjtBHMS.Service.Messaging.ManualInspectionSafetyAssessmentReport;
using GxjtBHMS.Models.ManualInspectionSafetyAssessmentTable;
using GxjtBHMS.Service.Messaging.Home;

namespace GxjtBHMS.Service.ManualInspectionSafetyAssessmentReportService
{
    public class GetManualInspectionSafetyAssessmentReportService : ServiceBase
    {
        IGetManualInspectionSafetyAssessmentReportDAL _getManualInspectionSafetyAssessmentReportDAL;
        IGetManualInspectionSafetyAssessmentStateDAL _getManualInspectionSafetyAssessmentStateDAL;
        public GetManualInspectionSafetyAssessmentReportService()
        {
            _getManualInspectionSafetyAssessmentReportDAL = new NinjectFactory().GetInstance<IGetManualInspectionSafetyAssessmentReportDAL>();
            _getManualInspectionSafetyAssessmentStateDAL = new NinjectFactory().GetInstance<IGetManualInspectionSafetyAssessmentStateDAL>();
        }

        public ManualInspectionSafetyAssessmentReportResponse GetManualInspectionSafetyAssessmentReportList(ManualInspectionSafetyAssessmentSearchRequest req)
        {
            var resp = new ManualInspectionSafetyAssessmentReportResponse();
            IList<Func<ManualInspectionSafetyAssessmentReportTable, bool>> ps = new List<Func<ManualInspectionSafetyAssessmentReportTable, bool>>();
            try
            {
                DealWithContainsTime(req, ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                var source = _getManualInspectionSafetyAssessmentReportDAL.FindBy(ps, req.CurrentPageIndex, numberOfResultsPrePage, ServiceConstant.AssessmentResultStateNavigationProperty);

                if (HasNoSearchResult(source))
                {
                    resp.Message = "无记录！";
                }
                else
                {
                    resp.TotalResultCount = _getManualInspectionSafetyAssessmentReportDAL.GetCountByContains(ps);
                    resp.ManualInspectionSafetyAssessmentReport = source;
                    resp.Succeed = true;
                }
            }
            catch (Exception ex)
            {
                resp.Message = "搜索人工巡检安全评估报告发生错误！";
                Log(ex);
            }
            return resp;
        }

        public SafetyAssessmentResultSearchResponse GetManualInspectionSafetyAssessmentReportResult()
        {

            var source = _getManualInspectionSafetyAssessmentReportDAL.FindBy(ServiceConstant.AssessmentResultStateNavigationProperty).OrderBy(m => m.ReportTime).Last();
            var result = new SafetyAssessmentResultSearchResponse()
            {
                ManualInspectionSafetyAssessmentResult = source.AssessmentResultState.AssessmentGrade
            };
            return result;
        }

        public IEnumerable<ManualInspectionSafetyAssessmentStateTable> GetAllTestType()
        {
          return _getManualInspectionSafetyAssessmentStateDAL.FindAll();
        }

        void DealWithContainsTime(ManualInspectionSafetyAssessmentSearchRequest req, IList<Func<ManualInspectionSafetyAssessmentReportTable, bool>> ps)
        {
            if (req.StartTime.Year != 1)
            {
                ps.Add(m => m.ReportTime >= req.StartTime);
                ps.Add(m => m.ReportTime < req.EndTime);
            };
        }

        /// <summary>
        /// 判断是否有记录
        /// </summary>
        /// <param name="SecondLevelSafetyAssessmentReports"></param>
        /// <returns></returns>
        protected bool HasNoSearchResult(IEnumerable<ManualInspectionSafetyAssessmentReportTable> SecondLevelSafetyAssessmentReports)
        {
            return SecondLevelSafetyAssessmentReports.Count() == 0;
        }
        public PagedResponse GetTotalPages()
        {
            IEnumerable<ManualInspectionSafetyAssessmentReportTable> source = _getManualInspectionSafetyAssessmentReportDAL.FindAll();
            PagedResponse resp = new PagedResponse();
            try
            {
                resp.TotalResultCount = source.Count();
                if (resp.TotalResultCount <= 0)
                {
                    resp.Message = "无记录!";
                }
                else
                {
                    resp.Succeed = true;
                }
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return resp;
        }

        public ResponseBase UploadSecondlevelSafetyAssessmentReport(ManualInspectionSafetyAssementReportUploadRequest req)
        {
            ResponseBase resp = new ResponseBase();
            try
            {
                var uploadReport = new ManualInspectionSafetyAssessmentReportTable()
                {
                    AssessmentResultStateId =req.ReportGradeId,
                    ReportPeriods = req.ReportName,
                    ReportTime = req.uploadDate,
                    ReprotPath = req.ReportPath,

                };
                _getManualInspectionSafetyAssessmentReportDAL.Add(uploadReport);
                resp.Succeed = true;
                resp.Message = "文件上传成功！";
            }
            catch (Exception ex)
            {
                resp.Succeed = false;
                resp.Message = "文件上传失败！";
                Log(ex);
            }
            return resp;

        }

        public SecondLevelSafetyAssessmentReportDownloadResponse GetSecondLevelSafetyAssessmentReportByReportName(SecondLevelSafetyAssementReportUploadRequest req)
        {
            var resp = new SecondLevelSafetyAssessmentReportDownloadResponse();
            try
            {
                resp.ReprotPath = _getManualInspectionSafetyAssessmentReportDAL.FindBy(m => m.ReprotPath == req.ReportPath).SingleOrDefault().ReprotPath;
                resp.Message = "下载成功！";
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Succeed = false;
                resp.Message = "下载失败！";
                Log(ex);
            }
            return resp;
        }

        public bool GetReportNameIsNotHas(string reportName)
        {
           var reportNameCount= _getManualInspectionSafetyAssessmentReportDAL.FindBy(m => m.ReportPeriods == reportName).Count();
            if (reportNameCount>0)
            {
                return false;
            }
            return true;
        }

        public ResponseBase DeleteSecondLevelSafetyAssessmentReport(ManualInspectionSafetyAssementReportUploadRequest req)
        {
            ResponseBase resp = new ResponseBase();
            IList<Func<ManualInspectionSafetyAssessmentReportTable, bool>> ps = new List<Func<ManualInspectionSafetyAssessmentReportTable, bool>>();
            DealWithDeleteConditon(req, ps);
            
            try
            {
                var source = _getManualInspectionSafetyAssessmentReportDAL.FindBy(ps).SingleOrDefault();
                _getManualInspectionSafetyAssessmentReportDAL.Remove(source);
                resp.Succeed = true;
                resp.Message = "删除报告成功";
            }
            catch (Exception ex)
            {
                resp.Succeed = false;
                resp.Message = "删除报告失败！";
                Log(ex);
            }
            return resp;
        }


        void DealWithDeleteConditon(ManualInspectionSafetyAssementReportUploadRequest req, IList<Func<ManualInspectionSafetyAssessmentReportTable, bool>> ps)
        {
            ps.Add(m => m.ReprotPath == req.ReportPath);
        }



    }
}
