using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.IDAL

{
    public interface IThresholdValueSettingDAL<T> : IReadOnlyRepository<T, int>,IRepository<T>
    {
    }
}