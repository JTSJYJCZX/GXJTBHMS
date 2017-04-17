using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.MonitoringDatasDAL
{
    public class TemperatureDatasOriginalValueDAL : Repository<Basic_TemperatureTable, int>, ITemperatureDatasOriginalValueDAL
    {
        public override IEnumerable<Basic_TemperatureTable> FindBy(IList<Func<Basic_TemperatureTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var cxt = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, cxt.Basic_Temperatures);
                var result = DealWithConditions(ps.ToArray(), source);
                return result
                .OrderBy(m => m.PointsNumberId)
                .ThenByDescending(m => m.Time)
                .Skip((currentPageIndex - 1) * pageSize)
                .Take(pageSize)
                .ToList(); //排序、分页
            }
        }
    }
}
