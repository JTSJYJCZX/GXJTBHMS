using System;

namespace GxjtBHMS.Service.Messaging.ManualInspectionSafetyAssessmentReport
{
    public class ManualInspectionSafetyAssessmentSearchRequest
    {
        public int CurrentPageIndex { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
    }
}
