using GxjtBHMS.IDAL;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.SecondLevelSafetyAssessmentReportDAL
{
    public class GetSecondLevelSafetyAssessmentReportDAL : Repository<SecondAssessment_SecondLevelSafetyAssessmentReportTable, int>, IGetSecondLevelSafetyAssessmentReportDAL
    {

        public override IEnumerable<SecondAssessment_SecondLevelSafetyAssessmentReportTable> FindBy(IList<Func<SecondAssessment_SecondLevelSafetyAssessmentReportTable, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.Set<SecondAssessment_SecondLevelSafetyAssessmentReportTable>());//处理导航属性

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
