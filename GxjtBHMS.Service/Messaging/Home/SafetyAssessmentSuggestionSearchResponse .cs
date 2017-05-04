
namespace GxjtBHMS.Service.Messaging.Home
{
   public class SafetyAssessmentSuggestionSearchResponse
    {
        public string FirstSafetyAssessmentSuggestion_Displacement { get; set; }//一级安全评估-变形评估建议
        public string FirstSafetyAssessmentSuggestion_Stress { get; set; }//一级安全评估-应力评估建议
        public string FirstSafetyAssessmentSuggestion_CableForce { get; set; }//一级安全评估-吊杆评估建议

    }
}
