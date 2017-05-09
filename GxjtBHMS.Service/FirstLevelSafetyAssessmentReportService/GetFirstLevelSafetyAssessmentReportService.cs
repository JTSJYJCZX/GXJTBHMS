using GxjtBHMS.IDAL;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging;
using System.Linq;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Service.Messaging.Home;
using GxjtBHMS.IDAL.Home;

namespace GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService
{
    public class GetFirstLevelSafetyAssessmentReportService : ServiceBase
    {
        IGetFirstLevelSafetyAssessmentReportDAL _getFirstLevelSafetyAssessmentReportDAL;
        IGetFirstLevelSafetyAssessmentReportDisplacementResultDAL _getFirstLevelSafetyAssessmentReportResultDAL;
        public GetFirstLevelSafetyAssessmentReportService()
        {
            _getFirstLevelSafetyAssessmentReportDAL = new NinjectFactory()
                 .GetInstance<IGetFirstLevelSafetyAssessmentReportDAL>();
            _getFirstLevelSafetyAssessmentReportResultDAL = new NinjectFactory().GetInstance<IGetFirstLevelSafetyAssessmentReportDisplacementResultDAL>();

        }

        public FirstLevelSafetyAssessmentReportResponse GetFirstLevelSafetyAssessmentReportList(FirstLevelSafetyAssessmentSearchRequest req)
        {
            var resp = new FirstLevelSafetyAssessmentReportResponse();
            IList<Func<FirstAssessment_FirstLevelSafetyAssessmentReportTable, bool>> ps = new List<Func<FirstAssessment_FirstLevelSafetyAssessmentReportTable, bool>>();
            try
            {
                DealWithContainsTime(req,ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                var source = _getFirstLevelSafetyAssessmentReportDAL.FindBy(ps,req.CurrentPageIndex, numberOfResultsPrePage);

                if (HasNoSearchResult(source))
                {
                    resp.Message = "无记录！";
                }
                else
                {
                    resp.TotalResultCount = _getFirstLevelSafetyAssessmentReportDAL.GetCountByContains(ps);
                    resp.FirstLevelSafetyAssessmentReport = source;
                    resp.Succeed = true;
                }
            }
            catch (Exception ex)
            {
                resp.Message = "搜索一级安全评估报告发生错误！";
                Log(ex);
            }
            return resp;
        }

        /// <summary>
        /// 获得最近一次一级安全评估结果的结论
        /// </summary>
        /// <returns></returns>
        public SafetyAssessmentResultSearchResponse GetFirstSafetyAssessmentResult()
        {
            var result = new SafetyAssessmentResultSearchResponse();
            var ReportCount = _getFirstLevelSafetyAssessmentReportDAL.FindBy().Count();
            if (ReportCount > 0)
            {
                var source = _getFirstLevelSafetyAssessmentReportResultDAL.FindBy(ServiceConstant.ResultsAssessmentReport).OrderBy(m => m.AssessmentReportId).Last();
                result.FirstSafetyAssessmentResult_Displacement = source.DisplacementAssessmentResult.Substring(0,2);
                result.FirstSafetyAssessmentResult_CableForce = source.CableForceAssessmentResult.Substring(0,2);
                result.FirstSafetyAssessmentResult_Stress = source.StrainAssessmentResult.Substring(0,2);
                result.FirstSafetyAssessmentReportTime = source.AssessmentReport.ReportTime.ToShortDateString();               
            }
            else
            {
                result.FirstSafetyAssessmentResult_Displacement = ServiceConstant.NotEvaluated;
                result.FirstSafetyAssessmentResult_CableForce = ServiceConstant.NotEvaluated;
                result.FirstSafetyAssessmentResult_Stress = ServiceConstant.NotEvaluated;
                result.FirstSafetyAssessmentReportTime = ServiceConstant.NotEvaluated;
            }          
            return result;

        }
        /// <summary>
        /// 获得最近一次一级安全评估建议
        /// </summary>
        /// <returns></returns>
        public SafetyAssessmentSuggestionSearchResponse GetFirstSafetyAssessmentSuggestion()
        {
            var result = new SafetyAssessmentSuggestionSearchResponse ();
            var ReportCount = _getFirstLevelSafetyAssessmentReportResultDAL.FindBy().Count();
            if (ReportCount>0)
            {
                var source = _getFirstLevelSafetyAssessmentReportResultDAL.FindBy(ServiceConstant.ResultsAssessmentReport).OrderBy(m => m.AssessmentReportId).Last();
                result.FirstSafetyAssessmentSuggestion_CableForce = source.CableForceAssessmentSuggestion;
                result.FirstSafetyAssessmentSuggestion_Displacement = source.DisplacementAssessmentSuggestion;
                result.FirstSafetyAssessmentSuggestion_Stress = source.StrainAssessmentSuggestion;
            }
            else
            {
                result.FirstSafetyAssessmentSuggestion_CableForce = ServiceConstant.NotEvaluated;
                result.FirstSafetyAssessmentSuggestion_Displacement = ServiceConstant.NotEvaluated;
                result.FirstSafetyAssessmentSuggestion_Stress = ServiceConstant.NotEvaluated;
            }
            return result;
        }



        void DealWithContainsTime(FirstLevelSafetyAssessmentSearchRequest req, IList<Func<FirstAssessment_FirstLevelSafetyAssessmentReportTable, bool>> ps)
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
        /// <param name="FirstLevelSafetyAssessmentReports"></param>
        /// <returns></returns>
        protected bool HasNoSearchResult(IEnumerable<FirstAssessment_FirstLevelSafetyAssessmentReportTable> FirstLevelSafetyAssessmentReports)
        {
            return FirstLevelSafetyAssessmentReports.Count() == 0;
        }
        public PagedResponse GetTotalPages()
        {
            IEnumerable<FirstAssessment_FirstLevelSafetyAssessmentReportTable> source = _getFirstLevelSafetyAssessmentReportDAL.FindAll();
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
    }
}
