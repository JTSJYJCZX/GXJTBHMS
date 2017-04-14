using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.IDAL.SafetyPreWarning;

namespace GxjtBHMS.Service.SafetyPreWarningRealTimeHubService
{
    class Temperature_SafetyPreWarningRealTimePushService : GetOneTypeSafetyPreWarningRealTimePushServiceBase<SafetyPreWarning_TemperatureTable>
    {
        public Temperature_SafetyPreWarningRealTimePushService(ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_TemperatureTable> cfspwDAL) : base(cfspwDAL)
        {
        }
    }
}
