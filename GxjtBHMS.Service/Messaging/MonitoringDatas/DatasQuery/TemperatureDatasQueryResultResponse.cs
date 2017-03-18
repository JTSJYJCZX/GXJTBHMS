using System.Collections.Generic;
using GxjtBHMS.Service.ViewModels.DataQueryResult;

namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class TemperatureDatasQueryResultResponse : PagedResponse
    {
        public TemperatureDatasQueryResultResponse()
        {
            TemperatureDatas = new List<TemperatureDatasModel>();
        }
        /// <summary>
        /// 当前搜索的分页数据源
        /// </summary>
        public IEnumerable<TemperatureDatasModel> TemperatureDatas { get; set; }
    }
}
