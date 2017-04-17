using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ISteelLatticeStrainRealTimeDatasDAL : IReadOnlyRepository<Basic_SteelLatticeStrainTable , int>
    {
        IEnumerable<Basic_SteelLatticeStrainTable > GetRealTimeStrains(int pointPositionId);
    }
}
