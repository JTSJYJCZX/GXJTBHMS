using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;

namespace GxjtBHMS.IDAL

{
    public interface IGetFirstLevelSafetyAssessmentReportDAL : IReadOnlyRepository<FirstLevelSafetyAssessmentReportTable, int>,IRepository<FirstLevelSafetyAssessmentReportTable>
    {


    }
}