using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ITemperatureRealTimeDatasDAL : IReadOnlyRepository<TemperatureTable, int>
    {
        IEnumerable<TemperatureTable> GetRealTimeTemperature(int pointPositionId);
    }
}
