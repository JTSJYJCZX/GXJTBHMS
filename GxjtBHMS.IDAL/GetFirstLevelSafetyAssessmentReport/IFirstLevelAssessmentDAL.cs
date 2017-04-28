using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.IDAL.GetFirstLevelSafetyAssessmentReport
{
   public interface IFirstLevelAssessmentDAL<T>: IReadOnlyRepository<T, int>
    {
    }
}
