using GxjtBHMS.IDAL;
using System;
using System.Collections.Generic;
using GxjtBHMS.Service.Messaging;
using System.Linq;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;

namespace GxjtBHMS.Service.SecondLevelSafetyAssessmentReportService
{
    public class GetSecondLevelSafetyAssessmentReportService : ServiceBase
    {
        IGetSecondLevelSafetyAssessmentReportDAL _getSecondLevelSafetyAssessmentReportDAL;
        public GetSecondLevelSafetyAssessmentReportService()
        {
            _getSecondLevelSafetyAssessmentReportDAL = new NinjectFactory()
                 .GetInstance<IGetSecondLevelSafetyAssessmentReportDAL>();
        }

        public SecondLevelSafetyAssessmentReportResponse GetFirstLevelSafetyAssessmentReportList(SecondLevelSafetyAssessmentSearchRequest req)
        {
            var resp = new SecondLevelSafetyAssessmentReportResponse();
            IList<Func<SecondAssessment_SecondLevelSafetyAssessmentReportTable, bool>> ps = new List<Func<SecondAssessment_SecondLevelSafetyAssessmentReportTable, bool>>();
            try
            {
                DealWithContainsTime(req,ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                var source = _getSecondLevelSafetyAssessmentReportDAL.FindBy(ps,req.CurrentPageIndex, numberOfResultsPrePage);

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
    }
}
