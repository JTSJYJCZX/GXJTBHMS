using GxjtBHMS.Service.Interfaces.FirstLevelAssessmInerfaces;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.IDAL.GetFirstLevelSafetyAssessmentReport;
using System.Collections.Generic;
using System.Linq;
using NPOI.XWPF.UserModel;
using System;
using GxjtBHMS.Service.Messaging.FirstLevelSafetyAssessmentReport;


namespace GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService
{
    public class FirstLevelAssessmReportDownloadFileService : ServiceBase, IFirstLevelAssessmReportDownloadFileInerfaces
    {
        readonly IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable> _exceptionRecordDAL;
        readonly IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable> _resultDAL;
        readonly IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelSafetyAssessmentReportTable> _reportDAL;
        readonly AbstractFirstLevelSafetyReport _reportProcessor;
        public FirstLevelAssessmReportDownloadFileService(IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable> exceptionRecordDAL, IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable> resultDAL, IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelSafetyAssessmentReportTable> reportDAL, AbstractFirstLevelSafetyReport reportProcessor)
        {
            _exceptionRecordDAL = exceptionRecordDAL;
            _reportDAL = reportDAL;
            _resultDAL = resultDAL;
            _reportProcessor = reportProcessor;
        }

        /// <summary>
        /// 创建一份报告
        /// </summary>
        /// <returns></returns>
        public dynamic GetDownloadDatas(int reportId)
        {
            var resp = new FirstLevelSafetyAssessmentReportDownloadResponse();
            IList<Func<FirstAssessment_FirstLevelSafetyAssessmentReportTable, bool>> reportPs = new List<Func<FirstAssessment_FirstLevelSafetyAssessmentReportTable, bool>>();
            IList<Func<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable, bool>> exceptionRecordPs = new List<Func<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable, bool>>();
            IList<Func<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable, bool>> resultsPs = new List<Func<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable, bool>>();
            IEnumerable<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable> exceptionRecordData = new List<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable>();
            try
            {
                DealWithExceptionRecordReportId(reportId, exceptionRecordPs);
                DealWithReportId(reportId, reportPs);
                DealWithResultsReportId(reportId, resultsPs);
                var exceptionRecordModels = _exceptionRecordDAL.FindBy(exceptionRecordPs, ServiceConstant.ExceptionRecordAssessmentReport).ToList();
                var resultsModel = _resultDAL.FindBy(resultsPs, ServiceConstant.ResultsAssessmentReport).SingleOrDefault();
                var reportModel = _reportDAL.FindBy(reportPs, ServiceConstant.ReportAssessmentReasons).SingleOrDefault();
                var reportDownloadModel = new ReportDownloadModel(exceptionRecordModels, resultsModel, reportModel);
                //创建报告模板
                resp.Report = _reportProcessor.CreateReport(reportDownloadModel);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "报告下载出错！";
                Log(ex);
            }
            return resp;
        }


        /// <summary>
        /// 处理包含报告id的条件
        /// </summary>
        /// <param name="reportId"></param>
        /// <param name="ps"></param>
        void DealWithExceptionRecordReportId(int reportId, IList<Func<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable, bool>> ps)
        {
            ps.Add(m => m.AssessmentReportId == reportId);
        }
        void DealWithResultsReportId(int reportId, IList<Func<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable, bool>> ps)
        {
            ps.Add(m => m.AssessmentReportId == reportId);
        }
        void DealWithReportId(int reportId, IList<Func<FirstAssessment_FirstLevelSafetyAssessmentReportTable, bool>> ps)
        {
            ps.Add(m => m.Id == reportId);
        }

        /// <summary>
        /// 给报告动态赋值
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        public XWPFTable SetCellValue(XWPFTable table)
        {
            var reportTable = table;

            return reportTable;
        }

        









        ///// <summary>
        ///// 判断是否有记录
        ///// </summary>
        ///// <param name="Reports"></param>
        ///// <returns></returns>
        //protected bool HasNoReportResult(IEnumerable<FirstAssessment_FirstLevelSafetyAssessmentReportTable> Reports)
        //{
        //    return Reports.Count() == 0;
        //}
        //protected bool HasNoResultsResult(IEnumerable<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable> Results)
        //{
        //    return Results.Count() == 0;
        //}
        //protected bool HasNoexceptionRecordsResult(IEnumerable<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable> exceptionRecords)
        //{
        //    return exceptionRecords.Count() == 0;
        //}

        



    }
}
