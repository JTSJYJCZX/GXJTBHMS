using System;

namespace GxjtBHMS.Models.FirstLevelSafetyAssessmentTable
{
    public class FirstLevelSafetyAssessmentReportTable : EntityBase<int>
    {

        //报告期数
        public string ReportPeriods { get; set; }
        //报告生成时间
        public DateTime ReportTime { get; set; }
        //评估原因
        public string AssessmentReasons { get; set; }
    }
}
