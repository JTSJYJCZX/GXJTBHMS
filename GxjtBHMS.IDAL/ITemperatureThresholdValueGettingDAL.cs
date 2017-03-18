using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface ITemperatureThresholdValueGettingDAL : IReadOnlyRepository<TemperatureThresholdValueTable, int>, IRepository<TemperatureThresholdValueTable>
    {
        IEnumerable<TemperatureThresholdValueTable> GetTemperatureThresholdValue(int pointPositionId);

    }
}
