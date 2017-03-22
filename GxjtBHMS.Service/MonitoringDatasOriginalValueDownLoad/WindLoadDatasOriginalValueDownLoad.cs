using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Service.Interfaces.MonitoringDatasOriginalValueDownLoadInerfaces;
using GxjtBHMS.Service.Implementations.OriginalValueDownLoad;

namespace GxjtBHMS.Service.MonitoringDatasOriginalValueDownLoad
{
    public class WindLoadDatasOriginalValueDownload : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly IWindLoadDatasOriginalValueDownloadService _windLoadDatasOriginalValueDownloadService;
        public WindLoadDatasOriginalValueDownload()
        {
            _windLoadDatasOriginalValueDownloadService = new NinjectFactory().GetInstance<WindLoadDatasOriginalValueDownloadService>();
        }
        public override DownloadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _windLoadDatasOriginalValueDownloadService.SaveAs(req);
        }
    }
}
