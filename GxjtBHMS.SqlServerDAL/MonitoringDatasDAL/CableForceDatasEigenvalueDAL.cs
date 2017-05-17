﻿using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL
{
    public class CableForceDatasEigenvalueDAL : Repository<Eigenvalue_CableForceEigenvalueTable , int>,IMonitoringDatasEigenvalueDAL<Eigenvalue_CableForceEigenvalueTable >
    {
        public override IEnumerable<Eigenvalue_CableForceEigenvalueTable > FindBy(IList<Func<Eigenvalue_CableForceEigenvalueTable , bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.CableForceEigenvalues);//处理导航属性

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
