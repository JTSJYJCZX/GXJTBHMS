using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;

namespace GxjtBHMS.IDAL
{
    public interface IHumidityDatasOriginalValueDAL: IReadOnlyRepository<Basic_HumidityTable,int>
    {
    }
}