﻿using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL
{
    public class SteelArchStrainDatasOriginalValueDAL : Repository<SteelArchStrainTable, int>, ISteelArchStrainDatasOriginalValueDAL
    {
        public override IEnumerable<SteelArchStrainTable> FindBy(IList<Func<SteelArchStrainTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.SteelArchStrains);//处理导航属性

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