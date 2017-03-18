using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.RealTimeMonitoringDatas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.IDAL
{
    public interface IRealTimeCableForceDatasDAL : IReadOnlyRepository<CableForceTable, int>
    {
        IEnumerable<RealTimeCableForceModel> GetRealTimeCableForces(int pointPositionId);
    }
}
