using System;

namespace GxjtBHMS.Web.ViewModels.Home
{
    public class SafetyAssessmentModelsViewModel
    {
        public string FirstSafetyAssessmentResult_Displacement { get; set; }//一级安全评估-变形评估
        public string FirstSafetyAssessmentResult_Stress { get; set; }//一级安全评估-应力评估
        public string FirstSafetyAssessmentResult_CableForce { get; set; }//一级安全评估-吊杆评估
        public string SecondSafetyAssessmentResult { get; set; }//二级安全评估结果
        public string ManualInspectionSafetyAssessmentResult { get; set; }//人工巡检评估结果

    }
}
