using GxjtBHMS.Service.Interfaces.MonitoringDatasOriginalValueDownLoadInerfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.MonitoringDatasOriginalValueDownLoad
{
    class TemperatureDatasOriginalValueDownload:MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly ITemperatureDatasOriginalValueDownloadService _temperatureDatasOriginalValueDownloadService;
        public TemperatureDatasOriginalValueDownload()
        {
            _temperatureDatasOriginalValueDownloadService = new NinjectFactory().GetInstance<ITemperatureDatasOriginalValueDownloadService>();
        }

        public override DownloadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _temperatureDatasOriginalValueDownloadService.SaveAs(req);
        }
    }
}
