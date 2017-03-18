using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.RealTimeMonitoringDatas;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IRealTimeHumidityDatasDAL: IReadOnlyRepository<HumidityTable, int>, IRepository<HumidityTable>
    {
        IEnumerable<RealTimeHumidityModel> GetRealTimeHumidities(int pointPositionId);
    }
}
