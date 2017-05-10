using GxjtBHMS.IDAL;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging;
using System.Linq;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;
using GxjtBHMS.Service.Messaging.SecondLevelSafetyAssessmentReport;
using GxjtBHMS.Service.Messaging.Home;

namespace GxjtBHMS.Service.SecondLevelSafetyAssessmentReportService
{
    public class GetSecondLevelSafetyAssessmentReportService : ServiceBase
    {
        IGetSecondLevelSafetyAssessmentReportDAL _getSecondLevelSafetyAssessmentReportDAL;
        IGetSecondLevelSafetyAssessmentStateDAL _getSecondLevelSafetyAssessmentStateDAL;
        public GetSecondLevelSafetyAssessmentReportService()
        {
            _getSecondLevelSafetyAssessmentReportDAL = new NinjectFactory().GetInstance<IGetSecondLevelSafetyAssessmentReportDAL>();
            _getSecondLevelSafetyAssessmentStateDAL = new NinjectFactory().GetInstance<IGetSecondLevelSafetyAssessmentStateDAL>();
        }

        public SecondLevelSafetyAssessmentReportResponse GetSecondLevelSafetyAssessmentReportList(SecondLevelSafetyAssessmentSearchRequest req)
        {
            var resp = new SecondLevelSafetyAssessmentReportResponse();
            IList<Func<SecondAssessment_SecondLevelSafetyAssessmentReportTable, bool>> ps = new List<Func<SecondAssessment_SecondLevelSafetyAssessmentReportTable, bool>>();
            try
            {
                DealWithContainsTime(req, ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                var source = _getSecondLevelSafetyAssessmentReportDAL.FindBy(ps, req.CurrentPageIndex, numberOfResultsPrePage, ServiceConstant.AssessmentResultStateNavigationProperty);

                if (HasNoSearchResult(source))
                {
                    resp.Message = "无记录！";
                }
                else
                {
                    resp.TotalResultCount = _getSecondLevelSafetyAssessmentReportDAL.GetCountByContains(ps);
                    resp.SecondLevelSafetyAssessmentReport = source;
                    resp.Succeed = true;
                }
            }
            catch (Exception ex)
            {
                resp.Message = "搜索二级安全评估报告发生错误！";
                Log(ex);
            }
            return resp;
        }

        /// <summary>
        /// 获取最新二级安全评估结果
        /// </summary>
        /// <returns></returns>
        public SafetyAssessmentResultSearchResponse GetSecondLevelSafetyAssessmentResult()
        {
            var result = new SafetyAssessmentResultSearchResponse();
            var ReportCount = _getSecondLevelSafetyAssessmentReportDAL.FindBy(ServiceConstant.AssessmentResultStateNavigationProperty).Count();
            if (ReportCount > 0)
            {
                var source = _getSecondLevelSafetyAssessmentReportDAL.FindBy(ServiceConstant.AssessmentResultStateNavigationProperty).OrderBy(m => m.ReportTime).Last();
                result.SecondSafetyAssessmentReportTime = source.ReportTime.ToShortDateString();
                result.SecondSafetyAssessmentResult = source.AssessmentResultState.AssessmentGrade;
            }
            else
            {
                result.SecondSafetyAssessmentResult = ServiceConstant.NotEvaluated;
                result.SecondSafetyAssessmentReportTime = ServiceConstant.NotEvaluated;
            }           
            return result;

        }

        public IEnumerable<SecondAssessment_SecondLevelSafetyAssessmentStateTable> GetAllTestType()
        {
            return _getSecondLevelSafetyAssessmentStateDAL.FindAll();
        }

        void DealWithContainsTime(SecondLevelSafetyAssessmentSearchRequest req, IList<Func<SecondAssessment_SecondLevelSafetyAssessmentReportTable, bool>> ps)
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
        protected bool HasNoSearchResult(IEnumerable<SecondAssessment_SecondLevelSafetyAssessmentReportTable> SecondLevelSafetyAssessmentReports)
        {
            return SecondLevelSafetyAssessmentReports.Count() == 0;
        }
        public PagedResponse GetTotalPages()
        {
            IEnumerable<SecondAssessment_SecondLevelSafetyAssessmentReportTable> source = _getSecondLevelSafetyAssessmentReportDAL.FindAll();
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

        public ResponseBase UploadSecondlevelSafetyAssessmentReport(SecondLevelSafetyAssementReportUploadRequest req)
        {
            ResponseBase resp = new ResponseBase();
            try
            {
                var uploadReport = new SecondAssessment_SecondLevelSafetyAssessmentReportTable()
                {
                    AssessmentResultStateId = req.ReportGradeId,
                    ReportPeriods = req.ReportName,
                    ReportTime = req.uploadDate,
                    ReprotPath = req.ReportPath,

                };
                _getSecondLevelSafetyAssessmentReportDAL.Add(uploadReport);
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
                resp.ReprotPath = _getSecondLevelSafetyAssessmentReportDAL.FindBy(m => m.ReprotPath == req.ReportPath).SingleOrDefault().ReprotPath;
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
            var reportNameCount = _getSecondLevelSafetyAssessmentReportDAL.FindBy(m => m.ReportPeriods == reportName).Count();
            if (reportNameCount > 0)
            {
                return false;
            }
            return true;
        }

        public ResponseBase DeleteSecondLevelSafetyAssessmentReport(SecondLevelSafetyAssementReportUploadRequest req)
        {
            ResponseBase resp = new ResponseBase();
            IList<Func<SecondAssessment_SecondLevelSafetyAssessmentReportTable, bool>> ps = new List<Func<SecondAssessment_SecondLevelSafetyAssessmentReportTable, bool>>();
            DealWithDeleteConditon(req, ps);

            try
            {
                var source = _getSecondLevelSafetyAssessmentReportDAL.FindBy(ps).SingleOrDefault();
                _getSecondLevelSafetyAssessmentReportDAL.Remove(source);
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


        void DealWithDeleteConditon(SecondLevelSafetyAssementReportUploadRequest req, IList<Func<SecondAssessment_SecondLevelSafetyAssessmentReportTable, bool>> ps)
        {
            ps.Add(m => m.ReprotPath == req.ReportPath);
        }



    }
}
