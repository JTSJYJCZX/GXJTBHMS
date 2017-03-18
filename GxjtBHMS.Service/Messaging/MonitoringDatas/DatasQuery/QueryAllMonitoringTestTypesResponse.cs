using GxjtBHMS.Service.ViewModels.MonitoringDatas.TestType;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class QueryAllMonitoringTestTypesResponse : ResponseBase
    {
        public IEnumerable<MonitoringTestTypeViewModel> Datas { get; set; }
    }
}

