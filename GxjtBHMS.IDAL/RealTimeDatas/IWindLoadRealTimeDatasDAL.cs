using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IWindLoadRealTimeDatasDAL : IReadOnlyRepository<Basic_WindLoadTable , int>
    {
        IEnumerable<Basic_WindLoadTable > GetRealTimeWindLoad(int pointPositionId);
    }
}
