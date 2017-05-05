namespace GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService
{
    public abstract class AbstractFirstLevelSafetyReport
    {
        protected ReportDownloadModel _source;
        protected dynamic _result;
        /// <summary>
        /// 创建报告
        /// </summary>
        public abstract dynamic CreateReport(ReportDownloadModel Datas);

        public dynamic Create(ReportDownloadModel Datas)
        {
            _source = Datas;
            BuildHeader();
            BuildContent();
            return _result;
        }

        protected abstract void BuildHeader();

        protected abstract void BuildContent();
    }
}
