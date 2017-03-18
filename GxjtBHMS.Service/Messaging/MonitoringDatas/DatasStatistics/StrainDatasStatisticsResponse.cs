using GxjtBHMS.Service.ViewModels.DataQueryResult;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class StatisticsResponse:ResponseBase
    {

        public StatisticsResponse() {

            StatisticDatas = new List<ResultStatisticsModel>();
        }
        public IEnumerable<ResultStatisticsModel> StatisticDatas { get; set; }
    }
}
