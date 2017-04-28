﻿using System;

namespace GxjtBHMS.Service.Messaging.SecondLevelSafetyAssessmentReport
{
    public class SecondLevelSafetyAssementReportUploadRequest
    {
        public string ReportPath { get; set; }
        public DateTime uploadDate { get; set; }
        public string ReportName { get; set; }
        public int ReportGradeId { get; set; }
    }
}
