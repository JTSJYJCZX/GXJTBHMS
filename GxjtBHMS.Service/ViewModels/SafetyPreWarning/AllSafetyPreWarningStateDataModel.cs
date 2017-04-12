using System.Collections.Generic;

namespace GxjtBHMS.Service.ViewModels.SafetyPreWarning
{
    public class AllSafetyPreWarningStateDataModel
    {
        public string BridgeCurrentSafetyPreWarningState { get; set; }
        public IEnumerable<SafetyPreWarningStateAndTotalTimesModel> SafetyPreWarningStateData { get; set; }
    }
}
