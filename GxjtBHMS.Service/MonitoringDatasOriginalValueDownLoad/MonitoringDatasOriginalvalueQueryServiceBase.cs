using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    public abstract class MonitoringDatasOriginalvalueQueryServiceBase : ServiceBase
    {
        public abstract DownLoadOriginalvalueDatasResponse OriginalvalueSaveAsFile(DatasQueryResultRequestBase req);
    }
}
