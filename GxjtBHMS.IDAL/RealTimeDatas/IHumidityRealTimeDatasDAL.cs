using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IHumidityRealTimeDatasDAL : IReadOnlyRepository<Basic_HumidityTable, int>
    {
        IEnumerable<Basic_HumidityTable> GetRealTimeHumidity(int pointPositionId);
    }
}
