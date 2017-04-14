using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IHumidityRealTimeDatasDAL : IReadOnlyRepository<HumidityTable, int>
    {
        IEnumerable<HumidityTable> GetRealTimeHumidity(int pointPositionId);
    }
}
