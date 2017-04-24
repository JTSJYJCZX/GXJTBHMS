using System;

namespace GxjtBHMS.Models.FirstLevelSafetyAssessmentTable
{
    public class FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable : EntityBase<int>
    {

        //应变评估结果
        public string StrainAssessmentResult { get; set; }
        //应变评估建议
        public string StrainAssessmentSuggestion { get; set; }
        //变形评估结果
        public string DisplacementAssessmentResult { get; set; }
        //变形评估建议
        public string DisplacementAssessmentSuggestion { get; set; }
        //索力评估结果
        public string CableForceAssessmentResult { get; set; }
        //索力评估建议
        public string CableForceAssessmentSuggestion { get; set; }
        //报告编号外键
        public virtual FirstAssessment_FirstLevelSafetyAssessmentReportTable AssessmentReport { get; set; }
        public int AssessmentReportId { get; set; }


    }
}
