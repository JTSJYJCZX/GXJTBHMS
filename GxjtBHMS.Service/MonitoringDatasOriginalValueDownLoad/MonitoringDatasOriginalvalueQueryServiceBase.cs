using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    public abstract class MonitoringDatasOriginalvalueQueryServiceBase : ServiceBase
    {
        public abstract DownLoadOriginalvalueDatasResponse SaveAsFile(DatasQueryResultRequestBase req);
    }
}
