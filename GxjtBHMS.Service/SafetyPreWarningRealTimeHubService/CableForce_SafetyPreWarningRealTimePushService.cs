using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.IDAL.SafetyPreWarning;

namespace GxjtBHMS.Service.SafetyPreWarningRealTimeHubService
{
    class CableForce_SafetyPreWarningRealTimePushService : GetOneTypeSafetyPreWarningRealTimePushServiceBase<SafetyPreWarning_CableForceTable>
    {
        public CableForce_SafetyPreWarningRealTimePushService(ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_CableForceTable> cfspwDAL) : base(cfspwDAL)
        {
        }
    }
}
