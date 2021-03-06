﻿using GxjtBHMS.IDAL.AlarmDatasManagement;
using GxjtBHMS.Models.MonitoringDatasTable;
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
                    .OrderByDescending(m=>m.Id)
                    .Skip((currentPageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .ToList(); //排序、分页
            }            
        }
    }
}
