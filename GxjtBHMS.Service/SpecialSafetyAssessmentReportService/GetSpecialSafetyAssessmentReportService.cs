using GxjtBHMS.IDAL;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging;
using System.Linq;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Models.SpecialSafetyAssessmentReportTable;
using GxjtBHMS.Service.Messaging.SpecialSafetyAssessmentReport;

namespace GxjtBHMS.Service.SpecialSafetyAssessmentReportService
{
    public class GetSpecialSafetyAssessmentReportService : ServiceBase
    {
        IGetSpecialSafetyAssessmentReportDAL _getSpecialSafetyAssessmentReportDAL;
        
        public GetSpecialSafetyAssessmentReportService()
        {
            _getSpecialSafetyAssessmentReportDAL = new NinjectFactory().GetInstance<IGetSpecialSafetyAssessmentReportDAL>();
            
        }

        public SpecialSafetyAssessmentReportResponse GetSpecialSafetyAssessmentReportList(SpecialSafetyAssessmentSearchRequest req)
        {
            var resp = new SpecialSafetyAssessmentReportResponse();
            IList<Func<SpecialAssessment_SpecialSafetyAssessmentReportTable, bool>> ps = new List<Func<SpecialAssessment_SpecialSafetyAssessmentReportTable, bool>>();
            try
            {
                DealWithContainsTime(req, ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                var source = _getSpecialSafetyAssessmentReportDAL.FindBy(ps, req.CurrentPageIndex, numberOfResultsPrePage);

                if (HasNoSearchResult(source))
                {
                    resp.Message = "无记录";
                }
                else
                {
                    resp.TotalResultCount = _getSpecialSafetyAssessmentReportDAL.GetCountByContains(ps);
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

        public IEnumerable<SpecialAssessment_SpecialSafetyAssessmentReportTable> GetAllTestType()
        {
          return _getSpecialSafetyAssessmentReportDAL.FindAll();
        }

        void DealWithContainsTime(SpecialSafetyAssessmentSearchRequest req, IList<Func<SpecialAssessment_SpecialSafetyAssessmentReportTable, bool>> ps)
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
        protected bool HasNoSearchResult(IEnumerable<SpecialAssessment_SpecialSafetyAssessmentReportTable> SecondLevelSafetyAssessmentReports)
        {
            return SecondLevelSafetyAssessmentReports.Count() == 0;
        }
        public PagedResponse GetTotalPages()
        {
            IEnumerable<SpecialAssessment_SpecialSafetyAssessmentReportTable> source = _getSpecialSafetyAssessmentReportDAL.FindAll();
            PagedResponse resp = new PagedResponse();
            try
            {
                resp.TotalResultCount = source.Count();
                if (resp.TotalResultCount <= 0)
                {
                    resp.Message = "无记录";
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

        public ResponseBase UploadSpecialSafetyAssessmentReport(SpecialSafetyAssementReportUploadRequest req)
        {
            ResponseBase resp = new ResponseBase();
            try
            {
                var uploadReport = new SpecialAssessment_SpecialSafetyAssessmentReportTable()
                {
                    ReportPeriods = req.ReportName,
                    ReportTime = req.uploadDate,
                    ReprotPath = req.ReportPath,

                };
                _getSpecialSafetyAssessmentReportDAL.Add(uploadReport);
                resp.Succeed = true;
                resp.Message = "文件上传成功";
            }
            catch (Exception ex)
            {
                resp.Succeed = false;
                resp.Message = "文件上传失败";
                Log(ex);
            }
            return resp;

        }

        public SpecialSafetyAssessmentReportDownloadResponse GetSpecialSafetyAssessmentReportByReportName(SpecialSafetyAssementReportUploadRequest req)
        {
            var resp = new SpecialSafetyAssessmentReportDownloadResponse();
            try
            {
                resp.ReprotPath = _getSpecialSafetyAssessmentReportDAL.FindBy(m => m.ReprotPath == req.ReportPath).SingleOrDefault().ReprotPath;
                resp.Message = "下载成功";
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Succeed = false;
                resp.Message = "下载失败";
                Log(ex);
            }
            return resp;
        }

        public bool GetReportNameIsNotHas(string reportName)
        {
           var reportNameCount= _getSpecialSafetyAssessmentReportDAL.FindBy(m => m.ReportPeriods == reportName).Count();
            if (reportNameCount>0)
            {
                return false;
            }
            return true;
        }

        public ResponseBase DeleteSpecialSafetyAssessmentReport(SpecialSafetyAssementReportUploadRequest req)
        {
            ResponseBase resp = new ResponseBase();
            IList<Func<SpecialAssessment_SpecialSafetyAssessmentReportTable, bool>> ps = new List<Func<SpecialAssessment_SpecialSafetyAssessmentReportTable, bool>>();
            DealWithDeleteConditon(req, ps);
            
            try
            {
                var source = _getSpecialSafetyAssessmentReportDAL.FindBy(ps).SingleOrDefault();
                _getSpecialSafetyAssessmentReportDAL.Remove(source);
                resp.Succeed = true;
                resp.Message = "删除报告成功";
            }
            catch (Exception ex)
            {
                resp.Succeed = false;
                resp.Message = "删除报告失败";
                Log(ex);
            }
            return resp;
        }


        void DealWithDeleteConditon(SpecialSafetyAssementReportUploadRequest req, IList<Func<SpecialAssessment_SpecialSafetyAssessmentReportTable, bool>> ps)
        {
            ps.Add(m => m.ReprotPath == req.ReportPath);
        }



    }
}
