using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL
{
    public class TemperatureDatasEigenvalueDAL : Repository<Eigenvalue_TemperatureEigenvalueTable, int>,IMonitoringDatasEigenvalueDAL<Eigenvalue_TemperatureEigenvalueTable>
    {
        public override IEnumerable<Eigenvalue_TemperatureEigenvalueTable> FindBy(IList<Func<Eigenvalue_TemperatureEigenvalueTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.TemperatureEigenvalues);//处理导航属性

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
