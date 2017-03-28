using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.AbnormalThresholdValueSetting;

namespace GxjtBHMS.IDAL

{
    public interface IAbnomalThresholdValueSettingDAL : IReadOnlyRepository<AbnormalThresholdValueTable, int>,IRepository<AbnormalThresholdValueTable>
    {


    }
}