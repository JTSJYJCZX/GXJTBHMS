using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IConcreteStrainRealTimeDatasDAL : IReadOnlyRepository<ConcreteStrainTable, int>
    {
        IEnumerable<ConcreteStrainTable> GetRealTimeStrains(int pointPositionId);
    }
}
