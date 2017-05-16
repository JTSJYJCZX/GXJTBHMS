using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;

namespace GxjtBHMS.IDAL

{
    public interface IGetSecondLevelSafetyAssessmentReportDAL : IReadOnlyRepository<SecondAssessment_SecondLevelSafetyAssessmentReportTable, int>,IRepository<SecondAssessment_SecondLevelSafetyAssessmentReportTable>
    {


    }
}