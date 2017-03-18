using System.Collections.Generic;
namespace GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts
{
    public class ChartGroupDataModel
    {
        public string CategoryName { get; set; }
        public string Unit { get; set; }
        public IEnumerable<ChartDataModel> Models { get; set; }
    }
}
