using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.MonitoringDatasTable;

namespace GxjtBHMS.IDAL
{
    public interface IWindLoadDatasOriginalValueDAL:IReadOnlyRepository<Basic_WindLoadTable , int>
    {
    }
}