using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ViewModels.SafetyPreWarning;

namespace GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces
{
    public interface ISafetyPreWarningRealTimePushService
    {
        AllSafetyPreWarningStateDataModel GetSafetyPreWarningRealTimePushModel(GetSafetyWarningDetailRequest req);
    }
}
