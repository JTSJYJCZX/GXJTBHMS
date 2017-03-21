using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Service.Interfaces.MonitoringDatasOriginalValueDownLoadInerfaces;

namespace GxjtBHMS.Service.MonitoringDatasOriginalValueDownLoad
{
    public class HumidityDatasOriginalValueDownLoad : MonitoringDatasOriginalvalueQueryServiceBase
    {
        readonly IHumidityDatasOriginalValueDownLoadService _humidityDatasOriginalValueDownLoadService;
        public HumidityDatasOriginalValueDownLoad()
        {
            _humidityDatasOriginalValueDownLoadService = new NinjectFactory().GetInstance<IHumidityDatasOriginalValueDownLoadService>();
        }
        public override DownLoadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req)
        {
            return _humidityDatasOriginalValueDownLoadService.SaveAs(req);
        }
    }
}
