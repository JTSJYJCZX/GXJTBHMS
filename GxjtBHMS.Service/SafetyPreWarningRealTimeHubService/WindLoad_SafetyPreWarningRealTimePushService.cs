using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.IDAL.SafetyPreWarning;

namespace GxjtBHMS.Service.SafetyPreWarningRealTimeHubService
{
    class WindLoad_SafetyPreWarningRealTimePushService : GetOneTypeSafetyPreWarningRealTimePushServiceBase<SafetyPreWarning_WindLoadTable>
    {
        public WindLoad_SafetyPreWarningRealTimePushService(ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_WindLoadTable> cfspwDAL) : base(cfspwDAL)
        {
        }
    }
}
