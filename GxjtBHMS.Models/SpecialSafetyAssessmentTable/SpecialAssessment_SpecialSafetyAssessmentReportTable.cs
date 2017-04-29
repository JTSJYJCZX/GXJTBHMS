using System;

namespace GxjtBHMS.Models.SpecialSafetyAssessmentReportTable
{
    public class SpecialAssessment_SpecialSafetyAssessmentReportTable : EntityBase<int>
    {

        //报告名称期数
        public string ReportPeriods { get; set; }
        //报告
        public string ReprotPath { get; set; }
        //报告生成时间
        public DateTime ReportTime { get; set; }
        

    }
}
