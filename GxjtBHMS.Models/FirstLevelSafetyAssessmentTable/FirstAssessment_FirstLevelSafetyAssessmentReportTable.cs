using System;

namespace GxjtBHMS.Models.FirstLevelSafetyAssessmentTable
{
    public class FirstAssessment_FirstLevelSafetyAssessmentReportTable : EntityBase<int>
    {
        //报告期数
        public string ReportPeriods { get; set; }
        //报告生成时间
        public DateTime ReportTime { get; set; }
        //评估原因
        public virtual FirstAssessment_FirstLevelSafetyAssessmentReasonsTable AssessmentReasons { get; set; }
        public int AssessmentReasonsId { get; set; }
    }
}
