using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ITemperatureDatasEigenvalueDAL: IReadOnlyRepository<TemperatureEigenvalueTable, int>
    {
      
    }
}
