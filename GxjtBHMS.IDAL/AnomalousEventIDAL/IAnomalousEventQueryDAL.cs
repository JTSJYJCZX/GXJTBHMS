using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.AnomalousEventTable;

namespace GxjtBHMS.IDAL.AnomalousEventIDAL
{
   public interface IAnomalousEventQueryDAL : IReadOnlyRepository<AnomalousEvent_AnomalousEventTable, int>
    {
    }
}
