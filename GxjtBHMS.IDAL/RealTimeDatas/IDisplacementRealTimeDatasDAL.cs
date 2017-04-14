using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IDisplacementRealTimeDatasDAL : IReadOnlyRepository<DisplacementTable, int>
    {
        IEnumerable<DisplacementTable> GetRealTimeDisplacement(int pointPositionId);
    }
}
