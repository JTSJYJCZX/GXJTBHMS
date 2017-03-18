using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.IDAL;

namespace GxjtBHMS.SqlServerDAL
{
    public interface ICableForceDatasDAL: IReadOnlyRepository<CableForceTable, int>
    {
    }
}