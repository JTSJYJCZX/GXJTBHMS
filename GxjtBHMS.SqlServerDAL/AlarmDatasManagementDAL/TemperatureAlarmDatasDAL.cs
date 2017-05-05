using GxjtBHMS.IDAL.AlarmDatasManagement;
using GxjtBHMS.Models.MonitoringDatasTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL
{
    public class TemperatureAlarmDatasDAL : Repository<SafetyPreWarning_TemperatureTable, int>, IAlarmDatasQueryDAL<SafetyPreWarning_TemperatureTable>
    {
        public override IEnumerable<SafetyPreWarning_TemperatureTable> FindBy(IList<Func<SafetyPreWarning_TemperatureTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.SafetyPreWarning_Temperatures);//处理导航属性

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
