using GxjtBHMS.Service.Interfaces.MonitoringDatasOriginalValueDownLoadInerfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.MonitoringDatasOriginalValueDownLoad
{
    class TemperatureDatasOriginalValueDownLoad:MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly ITemperatureDatasOriginalValueDownLoadService _temperatureDatasOriginalValueDownLoadService;
        public TemperatureDatasOriginalValueDownLoad()
        {
            _temperatureDatasOriginalValueDownLoadService = new NinjectFactory().GetInstance<ITemperatureDatasOriginalValueDownLoadService>();
        }

        public override DownLoadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _temperatureDatasOriginalValueDownLoadService.SaveAs(req);
        }
    }
}
