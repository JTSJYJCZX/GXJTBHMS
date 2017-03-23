using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IStrainThresholdValueGettingDAL : IReadOnlyRepository<ConcreteStrainThresholdValueTable, int>,  IRepository<ConcreteStrainThresholdValueTable>
    {
        IEnumerable<ConcreteStrainThresholdValueTable> GetStrainThresholdValue(int pointPositionId);
        
    }
}
