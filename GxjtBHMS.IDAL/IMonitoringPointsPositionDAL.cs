using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IMonitoringPointsPositionDAL : IReadOnlyRepository<MonitoringPointsPosition, int>
    {
        IEnumerable<MonitoringPointsPosition> GetModelsByTestTypeId(int ttId);
    }

}
