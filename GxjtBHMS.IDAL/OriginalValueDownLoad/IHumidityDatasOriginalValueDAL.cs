using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;

namespace GxjtBHMS.IDAL
{
    public interface IHumidityDatasOriginalValueDAL: IReadOnlyRepository<HumidityTable,int>
    {
    }
}