using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ISteelArchStrainRealTimeDatasDAL:IReadOnlyRepository<SteelArchStrainTable, int>
    {
        IEnumerable<SteelArchStrainTable> GetRealTimeStrains(int pointPositionId);
    }
}
