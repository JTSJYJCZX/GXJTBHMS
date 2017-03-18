using System.Collections.Generic;
using GxjtBHMS.Service.ViewModels.DataQueryResult;
using GxjtBHMS.Models;

namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class DisplaymentDatasQueryResultResponse : PagedResponse
    {

        public DisplaymentDatasQueryResultResponse()
        {
            displaymentDatas= new List<DisplaymentDatasModel>();

        }
        /// <summary>
        /// 当前搜索的分页数据源
        /// </summary>
        public IEnumerable<DisplaymentDatasModel> displaymentDatas { get; set; }
    }
}
