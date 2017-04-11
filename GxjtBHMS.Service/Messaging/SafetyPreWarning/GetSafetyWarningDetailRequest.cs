using System;

namespace GxjtBHMS.Service.Messaging.SafetyPreWarning
{
    public class GetSafetyWarningDetailRequest
    {
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
    }
}