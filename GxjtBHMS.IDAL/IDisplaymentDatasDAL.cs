using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;

namespace GxjtBHMS.SqlServerDAL
{
    public interface IDisplaymentDatasDAL: IReadOnlyRepository<DisplacementTable, int>
    {
    }
}