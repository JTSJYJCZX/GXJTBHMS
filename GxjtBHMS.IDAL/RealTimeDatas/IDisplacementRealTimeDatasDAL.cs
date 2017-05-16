using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IDisplacementRealTimeDatasDAL : IReadOnlyRepository<RealTime_DisplacementTable, int>
    {
        IEnumerable<RealTime_DisplacementTable> GetRealTimeDisplacement(int pointPositionId);
    }
}
