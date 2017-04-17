using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IThresholdValueDAL : IReadOnlyRepository<ThresholdValue_ConcreteStrainThresholdValueTable, int>, IRepository<ThresholdValue_ConcreteStrainThresholdValueTable>
    {
        IEnumerable<ThresholdValue_ConcreteStrainThresholdValueTable> GetStrainThresholdValue(int pointPositionId);
    }
}
