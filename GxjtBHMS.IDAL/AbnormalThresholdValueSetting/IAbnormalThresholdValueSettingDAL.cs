using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.AbnormalThresholdValueSetting;

namespace GxjtBHMS.IDAL

{
    public interface IAbnormalThresholdValueSettingDAL : IReadOnlyRepository<Abnormal_ThresholdValueTable, int>,IRepository<Abnormal_ThresholdValueTable>
    {

    }
}