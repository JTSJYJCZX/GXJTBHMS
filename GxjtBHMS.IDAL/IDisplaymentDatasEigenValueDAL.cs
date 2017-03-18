using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;

namespace GxjtBHMS.SqlServerDAL
{
    public interface IDisplaymentDatasEigenValueDAL : IReadOnlyRepository<DisplacementEigenvalueTable, int>
    {
    }
}