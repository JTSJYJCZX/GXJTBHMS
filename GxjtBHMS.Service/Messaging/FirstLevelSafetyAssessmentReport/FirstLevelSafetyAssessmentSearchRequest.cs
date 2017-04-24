using System;

namespace GxjtBHMS.Service.Messaging
{
    public class FirstLevelSafetyAssessmentSearchRequest
    {
        public int CurrentPageIndex { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
    }
}
