using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class SteelLatticeStrainOriginalValueDatasDownload : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly ISteelLatticeStrainDatasOriginalValueDownloadService _steelLatticeStrainDatasOriginalValueDownloadService;

        public SteelLatticeStrainOriginalValueDatasDownload()
        {
            _steelLatticeStrainDatasOriginalValueDownloadService = new NinjectFactory()
                .GetInstance<ISteelLatticeStrainDatasOriginalValueDownloadService>();
        }
         
        public override DownloadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _steelLatticeStrainDatasOriginalValueDownloadService.SaveAs(req);
        }
    }
}