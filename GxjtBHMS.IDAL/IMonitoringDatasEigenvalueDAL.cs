using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;

namespace GxjtBHMS.SqlServerDAL
{
    public interface IMonitoringDatasEigenvalueDAL<T> : IReadOnlyRepository<T, int>
    {
    }
}