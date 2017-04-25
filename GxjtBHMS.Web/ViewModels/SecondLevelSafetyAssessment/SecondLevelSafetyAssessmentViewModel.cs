using System;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.SecondLevelSafetyAssessment
{
    public class SecondLevelSafetyAssessmentViewModel
    {
        //报告名称期数
        public string ReportPeriods { get; set; }
        //报告
        public byte Report { get; }
        //报告生成时间
        public DateTime ReportTime { get; set; }
        //评估结果
        public string AssessmentResult { get; set; }
        //评估建议
        public string Suggestion { get; set; }
    }
}