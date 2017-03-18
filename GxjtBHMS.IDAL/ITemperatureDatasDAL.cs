using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ITemperatureDatasDAL : IReadOnlyRepository<TemperatureTable, int>
    {
      
    }
}
