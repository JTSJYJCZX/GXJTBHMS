using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.MonitoringDatasTable;

namespace GxjtBHMS.IDAL
{
    public interface IWindLoadDatasOriginalValueDAL:IReadOnlyRepository<WindLoadTable, int>
    {
    }
}