using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class DisplacementDatasOriginalValueDownload : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly IDisplacementDatasOriginalValueDownloadService _displacementmentDatasOriginalValueDownloadService;

        public DisplacementDatasOriginalValueDownload()
        {
            _displacementmentDatasOriginalValueDownloadService = new NinjectFactory()
                .GetInstance<IDisplacementDatasOriginalValueDownloadService>();
        }
         
        public override DownloadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _displacementmentDatasOriginalValueDownloadService.SaveAs(req);
        }
    }
}