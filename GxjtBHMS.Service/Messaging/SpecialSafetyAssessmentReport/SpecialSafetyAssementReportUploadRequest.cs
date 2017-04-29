using System;

namespace GxjtBHMS.Service.Messaging.SpecialSafetyAssessmentReport
{
    public class SpecialSafetyAssementReportUploadRequest
    {
        public string ReportPath { get; set; }
        public DateTime uploadDate { get; set; }
        public string ReportName { get; set; }
    }
}
