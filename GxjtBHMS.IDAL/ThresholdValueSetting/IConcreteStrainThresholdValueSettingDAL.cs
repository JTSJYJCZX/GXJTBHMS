using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.IDAL

{
    public interface IConcreteStrainThresholdValueSettingDAL : IReadOnlyRepository<ConcreteStrainThresholdValueTable, int>,IRepository<ConcreteStrainThresholdValueTable>
    {
    }
}