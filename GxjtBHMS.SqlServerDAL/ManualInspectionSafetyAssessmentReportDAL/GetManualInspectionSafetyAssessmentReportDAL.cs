using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ManualInspectionSafetyAssessmentTable;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ManualInspectionSafetyAssessmentReportDAL
{
    public class GetManualInspectionSafetyAssessmentReportDAL : Repository<ManualInspectionSafetyAssessmentReportTable, int>, IGetManualInspectionSafetyAssessmentReportDAL
    {
        public override IEnumerable<ManualInspectionSafetyAssessmentReportTable> FindBy(IList<Func<ManualInspectionSafetyAssessmentReportTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.Set<ManualInspectionSafetyAssessmentReportTable>());//处理导航属性

                var result = DealWithConditions(ps, source);//处理条件筛选

                return result
                    .OrderByDescending(m => m.ReportTime)
                    .Skip((currentPageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .ToList(); //排序、分页
            }
        }
    }
}
