using GxjtBHMS.Service.ViewModels.DataQueryResult;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class DisplaymentDatasStatisticsResponse:ResponseBase
    {

        public DisplaymentDatasStatisticsResponse() {

            StatisticDatas = new List<ResultStatisticsModel>();
        }
        public IEnumerable<ResultStatisticsModel> StatisticDatas { get; set; }
    }
}
