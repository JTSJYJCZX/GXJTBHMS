using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Web.ViewModels.DataQueryResult
{
    /// <summary>
    /// 数据查询结果视图类
    /// </summary>
    public class StrainDatasQueryResultView
    {
        public StrainDatasQueryResultView()
        {
            DataQueryResults = new List<StrainDatasView>();
            ResultStatistics = new List<ResultStatisticsView>();
            PaginatorModel = new PaginatorModel();
        }
        public IEnumerable<StrainDatasView> DataQueryResults { get; set; }
        public bool HasSearchResult { get { return DataQueryResults.Count() != 0; } }
        public IEnumerable<ResultStatisticsView> ResultStatistics { get; set; }
        public PaginatorModel PaginatorModel { get; set; }
    }
}   