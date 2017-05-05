using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.Home
{
    public class SafetyAssessmentModels
    {
        public SafetyAssessmentModels()
        {
            SafetyAssessments = new List<SafetyAssessmentModelsViewModel>();
        }
        public IEnumerable<SafetyAssessmentModelsViewModel> SafetyAssessments;
    }
}