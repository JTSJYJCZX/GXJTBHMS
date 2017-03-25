using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IMonitorDatasOriginalValueDownloadServiceBase
    {
        DownLoadDatasResponse SaveAs(DatasQueryResultRequestBase req);
    }
}
