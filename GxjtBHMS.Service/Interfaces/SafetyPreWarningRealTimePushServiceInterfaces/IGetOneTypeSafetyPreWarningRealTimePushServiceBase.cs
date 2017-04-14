using GxjtBHMS.Models.SafetyPreWarningTable;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ViewModels.SafetyPreWarning;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces
{
    public interface IGetOneTypeSafetyPreWarningRealTimePushService<T> where T: SafetyPreWarningBaseModel
    {
        SafetyPreWarningStateAndTotalTimesModel GetSafetyPreWarningStateModel(GetSafetyWarningDetailRequest req, int testTypeId) ;
        //IEnumerable<T> QuerySafetyPreWarningByTime(GetSafetyWarningDetailRequest req);
    }
}
