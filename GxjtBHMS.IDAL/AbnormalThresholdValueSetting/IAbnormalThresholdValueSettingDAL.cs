using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.AbnormalThresholdValueSetting;

namespace GxjtBHMS.IDAL

{
    public interface IAbnormalThresholdValueSettingDAL : IReadOnlyRepository<AbnormalThresholdValueTable, int>,IRepository<AbnormalThresholdValueTable>
    {


    }
}