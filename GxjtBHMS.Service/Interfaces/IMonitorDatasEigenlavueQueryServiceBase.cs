using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IMonitorDatasEigenlavueQueryServiceBase
    {
        ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req);
        DownLoadDatasResponse SaveAs(DatasQueryResultRequestBase req);
        long GetTotalResultCountBy(DatasQueryResultRequest req);
    }
}
