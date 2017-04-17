using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.MonitoringDatasDAL
{
    public class WindLoadDatasOriginalValueDAL: Repository<Basic_WindLoadTable , int>, IWindLoadDatasOriginalValueDAL
    {
        public override IEnumerable<Basic_WindLoadTable > FindBy(IList<Func<Basic_WindLoadTable , bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var cxt =new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties,cxt.WindLoads);
                var result = DealWithConditions(ps,source);
                return result.OrderBy(m => m.PointsNumberId)
                    .ThenBy(m => m.Time)
                    .Skip((currentPageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .ToArray();
            }
        }
    }
}
