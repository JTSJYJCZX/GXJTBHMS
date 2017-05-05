using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.IDAL.AnomalousEventIDAL
{
   public interface IAnomalousEventDAL<T> : IReadOnlyRepository<T, int>
    {
    }
}
