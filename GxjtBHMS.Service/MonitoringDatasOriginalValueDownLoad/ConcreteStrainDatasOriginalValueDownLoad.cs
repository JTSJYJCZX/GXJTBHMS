using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class ConcreteStrainDatasOriginalValueDownload : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly IConcreteStrainDatasOriginalValueDownloadService _concreteStrainDatasOriginalValueDownloadService;

        public ConcreteStrainDatasOriginalValueDownload()
        {
            _concreteStrainDatasOriginalValueDownloadService = new NinjectFactory()
                .GetInstance<IConcreteStrainDatasOriginalValueDownloadService>();
        }
         
        public override DownloadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _concreteStrainDatasOriginalValueDownloadService.SaveAs(req);
        }
    }
}