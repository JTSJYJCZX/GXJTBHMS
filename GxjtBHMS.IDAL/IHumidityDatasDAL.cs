using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IHumidityDatasDAL : IReadOnlyRepository<HumidityTable, int>
    {
      
    }
}
