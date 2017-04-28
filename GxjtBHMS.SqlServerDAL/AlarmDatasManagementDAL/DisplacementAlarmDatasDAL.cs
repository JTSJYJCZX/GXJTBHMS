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
    public class DisplacementAlarmDatasDAL: Repository<SafetyPreWarning_DisplacementTable, int>, IAlarmDatasQueryDAL<SafetyPreWarning_DisplacementTable>
    {
        public override IEnumerable<SafetyPreWarning_DisplacementTable> FindBy(IList<Func<SafetyPreWarning_DisplacementTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.SafetyPreWarning_Displacements);//处理导航属性

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
