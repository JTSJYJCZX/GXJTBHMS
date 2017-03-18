using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    public abstract class MonitoringDatasEigenvalueQueryServiceBase:ServiceBase
    {
        public abstract PagedResponse GetPaginatorDatas(DatasQueryResultRequest req);

        public abstract ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req);

        public abstract DownLoadDatasResponse SaveAsFile(DatasQueryResultRequestBase req);


    }
}
