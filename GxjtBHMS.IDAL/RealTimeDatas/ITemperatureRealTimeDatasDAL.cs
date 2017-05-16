using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ITemperatureRealTimeDatasDAL : IReadOnlyRepository<RealTime_TemperatureTable, int>
    {
        IEnumerable<RealTime_TemperatureTable> GetRealTimeTemperature(int pointPositionId);
    }
}
