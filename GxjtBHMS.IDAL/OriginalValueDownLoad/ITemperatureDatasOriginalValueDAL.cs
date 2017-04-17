using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;

namespace GxjtBHMS.IDAL
{
    public interface ITemperatureDatasOriginalValueDAL:IReadOnlyRepository<Basic_TemperatureTable,int>
    {
    }
}