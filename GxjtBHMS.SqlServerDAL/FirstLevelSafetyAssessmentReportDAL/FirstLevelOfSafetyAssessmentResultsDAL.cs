using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.IDAL.GetFirstLevelSafetyAssessmentReport;

namespace GxjtBHMS.SqlServerDAL.FirstLevelSafetyAssessmentReportDAL
{
    public class FirstLevelOfSafetyAssessmentResultsDAL : Repository<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable, int>, IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable>
    {
    }
}
