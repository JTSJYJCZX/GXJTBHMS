using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.AnomalousEventManagement;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces
{
    public interface IAnomalousEventManagementQueryService
    {
        AnomalousEventManagementResponse GetAnomalousEventManagementDatasBy(DatasQueryResultRequestBase req);
        AnomalousEventManagementResponse GetAnomalousEventByTime(DatasQueryResultRequestBase req);
        DownLoadDatasResponse SaveAs(DatasQueryResultRequestBase req);
        PagedResponse GetTotalPagesBy(DatasQueryResultRequest req);
    }
}
