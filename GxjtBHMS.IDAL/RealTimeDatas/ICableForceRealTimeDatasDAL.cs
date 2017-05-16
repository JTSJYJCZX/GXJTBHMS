using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ICableForceRealTimeDatasDAL : IReadOnlyRepository<RealTime_CableForceTable, int>
    {
        IEnumerable<RealTime_CableForceTable> GetRealTimeCableForce(int pointPositionId);
    }
}
