using GxjtBHMS.Models.SafetyPreWarningTable;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ViewModels.SafetyPreWarning;

namespace GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces
{
    public interface IGetOneTypeSafetyPreWarningRealTimePushService<T> where T: SafetyPreWarningBaseModel
    {
        SafetyPreWarningStateAndTotalTimesModel GetSafetyPreWarningStateModel(GetSafetyWarningDetailRequest req, int testTypeId) ;
    }
}
