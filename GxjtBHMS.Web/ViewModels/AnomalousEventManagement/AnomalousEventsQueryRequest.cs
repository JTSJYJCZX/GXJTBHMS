using GxjtBHMS.Service.Messaging.MonitoringDatas;

namespace GxjtBHMS.Web.ViewModels.AnomalousEventManagement
{
    public class AnomalousEventsQueryRequest: DatasQueryResultRequestBase
    {
        public int TestTypeId { get; set; }
    }
}