using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.RealTimeMonitoringDatas;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IRealTimeDisplaymentDatasDAL : IReadOnlyRepository<DisplacementTable, int>, IRepository<DisplacementTable>
    {
        IEnumerable<RealTimeDisplaymentModel> GetRealTimeDisplayments(int pointPositionId);
    }
}
