using GxjtBHMS.Service.ViewModels.DataQueryResult;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
