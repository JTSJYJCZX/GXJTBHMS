using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.ManualInspectionSafetyAssessmentTable;

namespace GxjtBHMS.IDAL

{
    public interface IGetManualInspectionSafetyAssessmentReportDAL : IReadOnlyRepository<ManualInspectionSafetyAssessmentReportTable, int>,IRepository<ManualInspectionSafetyAssessmentReportTable>
    {


    }
}