using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringPointsNumber;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class QueryAllMonitoringMonitoringPointsNumberResponse : ResponseBase
    {
        public IEnumerable<MonitoringPointsNumberViewModel> Datas { get; set; }
    }
}
