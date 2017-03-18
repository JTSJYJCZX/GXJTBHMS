using System.Collections.Generic;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models;

namespace GxjtBHMS.SqlServerDAL
{
    public class MonitoringPointsPositionDAL : Repository<MonitoringPointsPosition, int>, IMonitoringPointsPositionDAL
    {
        public IEnumerable<MonitoringPointsPosition> GetModelsByTestTypeId(int ttId)
        {
            return FindBy(m => m.TestTypeId == ttId);
        }
    }
}
