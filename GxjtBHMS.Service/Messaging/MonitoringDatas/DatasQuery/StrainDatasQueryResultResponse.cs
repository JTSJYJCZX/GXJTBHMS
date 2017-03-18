using System.Collections.Generic;
using GxjtBHMS.Service.ViewModels.DataQueryResult;

namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class StrainDatasQueryResultResponse : PagedResponse
    {
        public StrainDatasQueryResultResponse()
        {
            StrainDatas = new List<StrainDatasModel>();
        }
        /// <summary>
        /// 当前搜索的分页数据源
        /// </summary>
        public IEnumerable<StrainDatasModel> StrainDatas { get; set; }
    }
}
