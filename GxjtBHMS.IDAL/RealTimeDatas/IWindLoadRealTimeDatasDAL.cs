using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IWindLoadRealTimeDatasDAL : IReadOnlyRepository<WindLoadTable, int>
    {
        IEnumerable<WindLoadTable> GetRealTimeWindLoad(int pointPositionId);
    }
}
