using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IWindLoadRealTimeDatasDAL : IReadOnlyRepository<RealTime_WindLoadTable, int>
    {
        IEnumerable<RealTime_WindLoadTable> GetRealTimeWindLoad(int pointPositionId);
    }
}
