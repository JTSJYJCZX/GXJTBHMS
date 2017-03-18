using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IStrainThresholdValueGettingDAL : IReadOnlyRepository<StrainThresholdValueTable, int>,  IRepository<StrainThresholdValueTable>
    {
        IEnumerable<StrainThresholdValueTable> GetStrainThresholdValue(int pointPositionId);
        
    }
}
