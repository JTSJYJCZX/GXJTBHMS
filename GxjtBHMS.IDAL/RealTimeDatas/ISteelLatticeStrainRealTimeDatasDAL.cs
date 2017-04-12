using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ISteelLatticeStrainRealTimeDatasDAL : IReadOnlyRepository<SteelLatticeStrainTable, int>
    {
        IEnumerable<SteelLatticeStrainTable> GetRealTimeStrains(int pointPositionId);
    }
}
