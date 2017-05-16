using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.IDAL.GetFirstLevelSafetyAssessmentReport;

namespace GxjtBHMS.SqlServerDAL.FirstLevelSafetyAssessmentReportDAL
{
    public class FirstLevelSafetyAssessmentReportDAL : Repository<FirstAssessment_FirstLevelSafetyAssessmentReportTable, int>, IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelSafetyAssessmentReportTable>
    {
    }
}
