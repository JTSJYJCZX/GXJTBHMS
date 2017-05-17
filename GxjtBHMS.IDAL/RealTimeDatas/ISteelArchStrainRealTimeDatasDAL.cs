using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ISteelArchStrainRealTimeDatasDAL:IReadOnlyRepository<RealTime_SteelArchStrainTable, int>
    {
        IEnumerable<RealTime_SteelArchStrainTable> GetRealTimeStrains(int pointPositionId);
    }
}
