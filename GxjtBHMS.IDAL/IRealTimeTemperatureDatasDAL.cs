using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.RealTimeMonitoringDatas;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IRealTimeTemperatureDatasDAL : IReadOnlyRepository<TemperatureTable, int>, IRepository<TemperatureTable>
    {
        IEnumerable<RealTimeTemperatureModel> GetRealTimeTemperatures(int pointPositionId);
        
    }
}
