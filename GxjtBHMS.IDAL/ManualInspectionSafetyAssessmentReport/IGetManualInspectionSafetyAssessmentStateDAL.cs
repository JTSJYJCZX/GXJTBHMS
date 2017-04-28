using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.ManualInspectionSafetyAssessmentTable;

namespace GxjtBHMS.IDAL

{
    public interface IGetManualInspectionSafetyAssessmentStateDAL : IReadOnlyRepository<ManualInspectionSafetyAssessmentStateTable, int>,IRepository<ManualInspectionSafetyAssessmentStateTable>
    {   }
}