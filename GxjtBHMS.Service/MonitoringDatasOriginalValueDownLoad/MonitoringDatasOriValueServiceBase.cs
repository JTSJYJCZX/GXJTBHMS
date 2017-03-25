using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.MonitoringDatasOriginalValueDownLoad
{
    public abstract class MonitoringDatasOriValueServiceBase: ServiceBase
    {
        public abstract DownLoadDatasResponse SaveAs(DatasQueryResultRequestBase req);
    }
}
