using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public  interface IMonitoringPointsNumberDAL : IReadOnlyRepository<MonitoringPointsNumber, int>
    {
        IEnumerable<MonitoringPointsNumber> GetModelsByPointsPositionId(int ppId);

    }
}
