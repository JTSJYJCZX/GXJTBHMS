using GxjtBHMS.Models.MonitoringDatasTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.SafetyPreWarningDAL
{

    public class SafetyPreWarning_CableFrceTableDAL : Repository<SafetyPreWarning_CableForceTable, int>, ISafetyPreWarningDetailDAL<SafetyPreWarning_CableForceTable>
    {
        public override IEnumerable<SafetyPreWarning_CableForceTable> FindBy(IList<Func<SafetyPreWarning_CableForceTable, bool>> ps, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.Set<SafetyPreWarning_CableForceTable>());//处理导航属性

                var result = DealWithConditions(ps.ToArray(), source);//处理条件筛选

                return result
                    .OrderBy(m => m.Id)
                    .ToList(); //排序、分页
            }
        }
    }


}

