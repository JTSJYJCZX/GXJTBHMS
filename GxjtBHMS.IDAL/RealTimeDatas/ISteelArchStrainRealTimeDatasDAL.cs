using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ISteelArchStrainRealTimeDatasDAL:IReadOnlyRepository<Basic_SteelArchStrainTable , int>
    {
        IEnumerable<Basic_SteelArchStrainTable > GetRealTimeStrains(int pointPositionId);
    }
}
