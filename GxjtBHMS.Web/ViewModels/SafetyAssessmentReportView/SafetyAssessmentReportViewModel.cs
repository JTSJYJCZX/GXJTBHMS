using System;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.SafetyAssessmentReportView
{
    public class SafetyAssessmentReportViewModel
    {
        //报告名称，报告期数+报告名字
        public string ReportName { get; set; }
        //报告生成时间
        public DateTime ReportTime { get; set; }
        //报告在服务器保存的路径
        public string  ReporePath { get; set; }
        //评定状态，二级安全评估用
        public string  AssessmentState { get; set; }
        //评定等级，二级安全评估用
        public string  AssessmentGrade { get; set; }

    }
}