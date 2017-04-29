using GxjtBHMS.IDAL;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;
using GxjtBHMS.Models.SpecialSafetyAssessmentReportTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.SpecialSafetyAssessmentReportDAL
{
    public class GetSpecialSafetyAssessmentReportDAL : Repository<SpecialAssessment_SpecialSafetyAssessmentReportTable, int>, IGetSpecialSafetyAssessmentReportDAL
    {

        public override IEnumerable<SpecialAssessment_SpecialSafetyAssessmentReportTable> FindBy(IList<Func<SpecialAssessment_SpecialSafetyAssessmentReportTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.Set<SpecialAssessment_SpecialSafetyAssessmentReportTable>());//处理导航属性

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
