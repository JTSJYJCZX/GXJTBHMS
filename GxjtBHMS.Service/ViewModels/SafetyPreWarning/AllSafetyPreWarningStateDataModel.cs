using System.Collections.Generic;

namespace GxjtBHMS.Service.ViewModels.SafetyPreWarning
{
    public class AllSafetyPreWarningStateDataModel: SafetyStateModel
    {
        public IEnumerable<SafetyPreWarningStateAndTotalTimesModel> SafetyPreWarningStateData { get; set; }
    }
}
