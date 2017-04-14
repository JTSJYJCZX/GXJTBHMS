using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.IDAL.SafetyPreWarning;

namespace GxjtBHMS.Service.SafetyPreWarningRealTimeHubService
{
    class Displacement_SafetyPreWarningRealTimePushService : GetOneTypeSafetyPreWarningRealTimePushServiceBase<SafetyPreWarning_DisplacementTable>
    {
        public Displacement_SafetyPreWarningRealTimePushService(ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_DisplacementTable> cfspwDAL) : base(cfspwDAL)
        {
        }
    }
}
