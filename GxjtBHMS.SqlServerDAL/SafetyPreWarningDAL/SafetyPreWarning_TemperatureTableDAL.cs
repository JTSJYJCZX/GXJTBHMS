using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.SqlServerDAL;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.SafetyPreWarningDAL
{
   
    public class SafetyPreWarning_TemperatureTableDAL : Repository<SafetyPreWarning_TemperatureTable, int>, ISafetyPreWarningDetailDAL<SafetyPreWarning_TemperatureTable>
    {
        public override IEnumerable<SafetyPreWarning_TemperatureTable> FindBy(IList<Func<SafetyPreWarning_TemperatureTable, bool>> ps, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.Set<SafetyPreWarning_TemperatureTable>());//处理导航属性

                var result = DealWithConditions(ps.ToArray(), source);//处理条件筛选

                return result
                    .OrderBy(m => m.Id)
                    .ToList(); //排序、分页
            }
        }
    }


}

