namespace GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService
{
    public abstract class AbstractFirstLevelSafetyReport
    {

        /// <summary>
        /// 创建报告
        /// </summary>
        public abstract dynamic CreateReport(ReportDownloadModel Datas);
      
    }
}
