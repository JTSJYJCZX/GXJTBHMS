using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IConcreteStrainRealTimeDatasDAL : IReadOnlyRepository<Basic_ConcreteStrainTable , int>
    {
        IEnumerable<Basic_ConcreteStrainTable > GetRealTimeStrains(int pointPositionId);
    }
}
