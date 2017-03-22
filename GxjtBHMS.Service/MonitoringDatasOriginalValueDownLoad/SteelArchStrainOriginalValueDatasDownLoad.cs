using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class SteelArchStrainOriginalValueDatasDownload : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly ISteelArchStrainDatasOriginalValueDownloadService _steelArchStrainDatasOriginalValueDownloadService;

        public SteelArchStrainOriginalValueDatasDownload()
        {
            _steelArchStrainDatasOriginalValueDownloadService = new NinjectFactory()
                .GetInstance<ISteelArchStrainDatasOriginalValueDownloadService>();
        }
         
        public override DownloadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _steelArchStrainDatasOriginalValueDownloadService.SaveAs(req);
        }
    }
}