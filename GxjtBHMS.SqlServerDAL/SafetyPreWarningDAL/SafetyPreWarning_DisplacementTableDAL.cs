﻿using GxjtBHMS.Models.MonitoringDatasTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.SafetyPreWarningDAL
{

    public class SafetyPreWarning_DisplacementTableDAL : Repository<SafetyPreWarning_DisplacementTable, int>, ISafetyPreWarningDetailDAL<SafetyPreWarning_DisplacementTable>
    {
        public override IEnumerable<SafetyPreWarning_DisplacementTable> FindBy(IList<Func<SafetyPreWarning_DisplacementTable, bool>> ps, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.Set<SafetyPreWarning_DisplacementTable>());//处理导航属性

                var result = DealWithConditions(ps.ToArray(), source);//处理条件筛选

                return result
                    .OrderBy(m => m.Id)
                    .ToList(); //排序、分页
            }
        }
    }


}

