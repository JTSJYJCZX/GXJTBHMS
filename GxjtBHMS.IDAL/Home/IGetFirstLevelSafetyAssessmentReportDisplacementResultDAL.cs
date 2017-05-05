using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;

namespace GxjtBHMS.IDAL.Home

{
    public interface IGetFirstLevelSafetyAssessmentReportDisplacementResultDAL : IReadOnlyRepository<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable, int>,IRepository<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable>
    {


    }
}