using GxjtBHMS.IDAL.AnomalousEventIDAL;
using GxjtBHMS.Models.AnomalousEventTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.AnomalousEventDAL
{
    public class AnomalousQueryDAL : Repository<AnomalousEvent_AnomalousEventTable, int>, IAnomalousEventQueryDAL
    {
        public override IEnumerable<AnomalousEvent_AnomalousEventTable> FindBy(IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.AnomalousEvent);//处理导航属性

                var result = DealWithConditions(ps.ToArray(), source);//处理条件筛选

                return result
                    .OrderByDescending(m => m.Id)
                    .Skip((currentPageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .ToList(); //排序、分页
            }
        }
    }
}
