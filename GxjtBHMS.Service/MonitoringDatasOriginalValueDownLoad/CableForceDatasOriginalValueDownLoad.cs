using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    class CableForceDatasOriginalValueDownLoad : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly ICableForceDatasOriginalValueDownLoadService _cableForceDatasOriginalValueDownLoadService;

        public CableForceDatasOriginalValueDownLoad()
        {
            _cableForceDatasOriginalValueDownLoadService = new NinjectFactory()
                .GetInstance<ICableForceDatasOriginalValueDownLoadService>();
        }
         
        public override DownLoadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _cableForceDatasOriginalValueDownLoadService.SaveAs(req);
        }
    }
}