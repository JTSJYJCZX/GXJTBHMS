using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IThresholdValueDAL : IReadOnlyRepository<ConcreteStrainThresholdValueTable, int>, IRepository<ConcreteStrainThresholdValueTable>
    {
        IEnumerable<ConcreteStrainThresholdValueTable> GetStrainThresholdValue(int pointPositionId);
    }
}
