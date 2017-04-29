using GxjtBHMS.IDAL;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System;

namespace GxjtBHMS.SqlServerDAL.FirstLevelSafetyAssessmentReportDAL
{
    public class GetFirstLevelSafetyAssessmentReportDAL : Repository<FirstAssessment_FirstLevelSafetyAssessmentReportTable, int>, IGetFirstLevelSafetyAssessmentReportDAL
    {
        public override IEnumerable<FirstAssessment_FirstLevelSafetyAssessmentReportTable> FindBy(IList<Func<FirstAssessment_FirstLevelSafetyAssessmentReportTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.Set<FirstAssessment_FirstLevelSafetyAssessmentReportTable>());//处理导航属性

                var result = DealWithConditions(ps.ToArray(), source);//处理条件筛选

                return result
                    .OrderByDescending(m => m.ReportTime)
                    .Skip((currentPageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .ToList(); //排序、分页
            }
        }
    }
}
