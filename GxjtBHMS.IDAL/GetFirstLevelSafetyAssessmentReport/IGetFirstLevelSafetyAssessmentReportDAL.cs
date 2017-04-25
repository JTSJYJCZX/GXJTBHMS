using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;

namespace GxjtBHMS.IDAL

{
    public interface IGetFirstLevelSafetyAssessmentReportDAL : IReadOnlyRepository<FirstAssessment_FirstLevelSafetyAssessmentReportTable, int>,IRepository<FirstAssessment_FirstLevelSafetyAssessmentReportTable>
    {


    }
}