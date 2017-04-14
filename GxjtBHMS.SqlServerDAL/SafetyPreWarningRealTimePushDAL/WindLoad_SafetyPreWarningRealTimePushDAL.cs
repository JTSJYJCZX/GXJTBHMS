using GxjtBHMS.IDAL.SafetyPreWarning;
using GxjtBHMS.Models.MonitoringDatasTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.SafetyPreWarningRealTimePushDAL
{
    public class WindLoad_SafetyPreWarningRealTimePushDAL : Repository<SafetyPreWarning_WindLoadTable, int>, ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_WindLoadTable>
    {
        public override IEnumerable<SafetyPreWarning_WindLoadTable> FindBy(IList<Func<SafetyPreWarning_WindLoadTable, bool>> ps, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.Set<SafetyPreWarning_WindLoadTable>());//处理导航属性
                var result = DealWithConditions(ps.ToArray(), source);//处理条件筛选
                return result
                    .OrderBy(m => m.Id)
                    .ToList(); //排序、分页
            }
        }
    }
}
