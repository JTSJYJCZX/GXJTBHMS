using GxjtBHMS.IDAL.AnomalousEventIDAL;
using GxjtBHMS.Models.AnomalousEventTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.AnomalousEventDAL
{
    public class WindLoadAnomalousDAL : Repository<AnomalousEvent_WindLoadTable, int>,IAnomalousEventDAL<AnomalousEvent_WindLoadTable>
    {
        public override IEnumerable<AnomalousEvent_WindLoadTable> FindBy(IList<Func<AnomalousEvent_WindLoadTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.AnomalousEvent_WindLoads);//处理导航属性

                var result = DealWithConditions(ps.ToArray(), source);//处理条件筛选

                return result
                    .OrderByDescending(m => m.Time)
                    .ThenBy(m => m.PointsNumberId)
                    .Skip((currentPageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .ToList(); //排序、分页
            }
        }
    }
}
