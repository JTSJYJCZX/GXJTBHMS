using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class DisplacementDatasOriginalValueDownLoad : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly IDisplacementDatasOriginalValueDownLoadService _displacementmentDatasOriginalValueDownLoadService;

        public DisplacementDatasOriginalValueDownLoad()
        {
            _displacementmentDatasOriginalValueDownLoadService = new NinjectFactory()
                .GetInstance<IDisplacementDatasOriginalValueDownLoadService>();
        }
         
        public override DownLoadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _displacementmentDatasOriginalValueDownLoadService.SaveAs(req);
        }
    }
}