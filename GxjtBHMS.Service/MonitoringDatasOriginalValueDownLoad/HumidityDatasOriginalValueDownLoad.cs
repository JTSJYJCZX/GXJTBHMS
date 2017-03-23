using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Service.Interfaces.MonitoringDatasOriginalValueDownLoadInerfaces;

namespace GxjtBHMS.Service.MonitoringDatasOriginalValueDownLoad
{
    public class HumidityDatasOriginalValueDownload : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly IHumidityDatasOriginalValueDownloadService _humidityDatasOriginalValueDownloadService;
        public HumidityDatasOriginalValueDownload()
        {
            _humidityDatasOriginalValueDownloadService = new NinjectFactory().GetInstance<IHumidityDatasOriginalValueDownloadService>();
        }
        public override DownloadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _humidityDatasOriginalValueDownloadService.SaveAs(req);
        }
    }
}
