using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IMonitorDatasOriginalValueDownLoadServiceBase
    {
        DownLoadOriginalvalueDatasResponse SaveAs(DatasQueryResultRequestBase req);
    }
}
