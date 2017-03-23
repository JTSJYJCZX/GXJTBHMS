using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.IDAL

{
    public interface IThresholdValueSettingDAL : IReadOnlyRepository<ConcreteStrainThresholdValueTable, int>,IRepository<ConcreteStrainThresholdValueTable>
    {
    }
}