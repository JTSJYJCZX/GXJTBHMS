using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IHumidityRealTimeDatasDAL : IReadOnlyRepository<RealTime_HumidityTable, int>
    {
        IEnumerable<RealTime_HumidityTable> GetRealTimeHumidity(int pointPositionId);
    }
}
