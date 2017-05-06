namespace GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService
{
    public abstract class AbstractFirstLevelSafetyReport
    {
        protected ReportDownloadModel _source;
        protected dynamic _result;
        /// <summary>
        /// 创建报告
        /// </summary>
        public dynamic Create(ReportDownloadModel datas)
        {
            _source = datas;
            BuildHeader();
            BuildContent();
            return _result;
        }

        protected abstract void BuildHeader();

        protected abstract void BuildContent();
    }
}
