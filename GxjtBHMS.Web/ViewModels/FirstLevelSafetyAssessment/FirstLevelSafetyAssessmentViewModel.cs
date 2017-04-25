using System;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.FirstLevelSafetyAssessment
{
    public class FirstLevelSafetyAssessmentViewModel
    {
        public string ReportName { get; set; }
        public DateTime ReportTime { get; set; }
        public string  AssessmentState { get; set; }
        public string  AssessmentGrade { get; set; }

    }
}