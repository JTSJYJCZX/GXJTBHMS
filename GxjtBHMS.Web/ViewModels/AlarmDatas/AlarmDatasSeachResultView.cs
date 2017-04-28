using GxjtBHMS.Service.ViewModels;
using GxjtBHMS.Service.ViewModels.AlarmDatasModel;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Web.ViewModels.AlarmDatas
{
    /// <summary>
    /// 报警值查询结果视图类
    /// </summary>
    public class AlarmDatasSeachResultView
    {
        public PaginatorModel PaginatorModel { get; set; }
        public IEnumerable<AlarmDatasModel> Datas { get; set; }
        
    }
}