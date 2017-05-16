using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IConcreteStrainRealTimeDatasDAL : IReadOnlyRepository<RealTime_ConcreteStrainTable, int>
    {
        IEnumerable<RealTime_ConcreteStrainTable> GetRealTimeStrains(int pointPositionId);
    }
}
