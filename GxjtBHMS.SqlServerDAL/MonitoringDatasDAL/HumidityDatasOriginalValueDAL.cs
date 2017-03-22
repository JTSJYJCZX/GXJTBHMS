using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.MonitoringDatasDAL
{
    public class HumidityDatasOriginalValueDAL: Repository<HumidityTable, int>, IHumidityDatasOriginalValueDAL
    {
        public override IEnumerable<HumidityTable> FindBy(IList<Func<HumidityTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var cxt = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, cxt.Humiditys);
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
