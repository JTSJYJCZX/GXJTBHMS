using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ISteelLatticeStrainRealTimeDatasDAL : IReadOnlyRepository<RealTime_SteelLatticeStrainTable, int>
    {
        IEnumerable<RealTime_SteelLatticeStrainTable> GetRealTimeStrains(int pointPositionId);
    }
}
