using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.IDAL.AlarmDatasManagement
{
    public interface IAlarmDatasQueryDAL<T> : IReadOnlyRepository<T, int>
    {

    }
}