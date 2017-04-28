using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.SqlServerDAL;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL
{
    public class WindLoadAlarmDatasDAL : Repository<SafetyPreWarning_WindLoadTable, int>, IAlarmDatasQueryDAL<SafetyPreWarning_WindLoadTable>
    {
        public override IEnumerable<SafetyPreWarning_WindLoadTable> FindBy(IList<Func<SafetyPreWarning_WindLoadTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.SafetyPreWarning_WindLoads);//处理导航属性

                var result = DealWithConditions(ps.ToArray(), source);//处理条件筛选

                return result
                    .OrderBy(m=>m.PointsNumberId)
                    .ThenByDescending(m => m.Time)
                    .Skip((currentPageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .ToList(); //排序、分页
            }            
        }
    }
}
