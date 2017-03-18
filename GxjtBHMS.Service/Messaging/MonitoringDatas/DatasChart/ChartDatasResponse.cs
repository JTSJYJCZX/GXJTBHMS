using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using System.Collections.Generic;
namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class ChartDatasResponse:ResponseBase
    {
        public IEnumerable<ChartGroupDataModel>  Datas { get; set; }
    }
}
