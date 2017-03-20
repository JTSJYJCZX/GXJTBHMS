using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class SteelLatticeStrainOriginalValueDatasDownLoad : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly ISteelLatticeStrainDatasOriginalValueDownLoadService _steelLatticeStrainDatasOriginalValueDownLoadService;

        public SteelLatticeStrainOriginalValueDatasDownLoad()
        {
            _steelLatticeStrainDatasOriginalValueDownLoadService = new NinjectFactory()
                .GetInstance<ISteelLatticeStrainDatasOriginalValueDownLoadService>();
        }
         
        public override DownLoadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _steelLatticeStrainDatasOriginalValueDownLoadService.SaveAs(req);
        }
    }
}