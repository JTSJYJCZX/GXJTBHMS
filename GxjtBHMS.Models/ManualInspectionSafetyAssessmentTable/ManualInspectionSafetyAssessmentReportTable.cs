using System;

namespace GxjtBHMS.Models.ManualInspectionSafetyAssessmentTable
{
    public class ManualInspectionSafetyAssessmentReportTable : EntityBase<int>
    {
        //报告名称期数
        public string ReportPeriods { get; set; }
        //报告
        public string ReprotPath { get; set; }
        //报告生成时间
        public DateTime ReportTime { get; set; }
        //评估结果
        public int AssessmentResultStateId { get; set; }
        public virtual ManualInspectionSafetyAssessmentStateTable AssessmentResultState { get; set; }


   

    }
}
