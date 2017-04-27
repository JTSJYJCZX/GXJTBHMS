using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;

namespace GxjtBHMS.IDAL

{
    public interface IGetSecondLevelSafetyAssessmentStateDAL : IReadOnlyRepository<SecondAssessment_SecondLevelSafetyAssessmentStateTable, int>,IRepository<SecondAssessment_SecondLevelSafetyAssessmentStateTable>
    {


    }
}