using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.SqlServerDAL
{
    public interface ISafetyPreWarningDetailDAL<T> : IReadOnlyRepository<T, int>
    {
    }
}