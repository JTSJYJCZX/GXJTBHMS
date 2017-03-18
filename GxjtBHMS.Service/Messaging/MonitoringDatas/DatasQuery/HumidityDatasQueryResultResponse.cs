using System.Collections.Generic;
using GxjtBHMS.Service.ViewModels.DataQueryResult;

namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class HumidityDatasQueryResultResponse : PagedResponse
    {
        public HumidityDatasQueryResultResponse()
        {
            HumidityDatas = new List<HumidityDatasModel>();
        }
        /// <summary>
        /// 当前搜索的分页数据源
        /// </summary>
        public IEnumerable<HumidityDatasModel> HumidityDatas { get; set; }
    }
}
