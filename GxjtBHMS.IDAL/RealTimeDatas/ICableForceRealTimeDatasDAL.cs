using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ICableForceRealTimeDatasDAL : IReadOnlyRepository<CableForceTable, int>
    {
        IEnumerable<CableForceTable> GetRealTimeCableForce(int pointPositionId);
    }
}
