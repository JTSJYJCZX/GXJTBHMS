using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using System.Collections.Generic;

namespace GxjtBHMS.SqlServerDAL
{
    public  class MonitoringPointsNumberDAL : Repository<MonitoringPointsNumber, int>, IMonitoringPointsNumberDAL
    {
        public IEnumerable<MonitoringPointsNumber> GetModelsByPointsPositionId(int ppId)
        {
            return FindBy(m => m.PointsPositionId == ppId);
        }

    }
}
