using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringPointsPosition;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class QueryAllMonitoringPointsPositionResponse:ResponseBase
    {
        public IEnumerable<MonitoringPointsPositionViewModel> Datas { get; set; }
    }
}
