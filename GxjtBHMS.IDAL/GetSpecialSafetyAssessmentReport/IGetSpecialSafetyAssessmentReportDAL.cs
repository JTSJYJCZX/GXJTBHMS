using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.SpecialSafetyAssessmentReportTable;

namespace GxjtBHMS.IDAL

{
    public interface IGetSpecialSafetyAssessmentReportDAL : IReadOnlyRepository<SpecialAssessment_SpecialSafetyAssessmentReportTable, int>,IRepository<SpecialAssessment_SpecialSafetyAssessmentReportTable>
    {

    }
}