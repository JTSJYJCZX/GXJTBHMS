using System;
using System.Collections.Generic;

namespace GxjtBHMS.Models
{
    public class AllSafetyWarningDatasModel
    {
        public string TotalSafetyPreWarningColor { get; set; }
        public string TotalSafetyPreWarningState { get; set; }
        public string PreFirstAssessmentReportTime { get; set; }

        public string CableForceSafetyPreWarningColor { get; set; }
        public string CableForceSafetyPreWarningState { get; set; }
        public int CableForceWarningGrade2Times { get; set; }
        public int CableForceWarningGrade3Times { get; set; }

        public string DisplacementSafetyPreWarningColor { get; set; }
        public string DisplacementSafetyPreWarningState { get; set; }
        public int DisplacementWarningGrade2Times { get; set; }
        public int DisplacementWarningGrade3Times { get; set; }

        public string WindLoadSafetyPreWarningColor { get; set; }
        public string WindLoadSafetyPreWarningState { get; set; }
        public int WindLoadWarningGrade2Times { get; set; }
        public int WindLoadWarningGrade3Times { get; set; }

        public string TemperatureSafetyPreWarningColor { get; set; }
        public string TemperatureSafetyPreWarningState { get; set; }
        public int TemperatureWarningGrade2Times { get; set; }
        public int TemperatureWarningGrade3Times { get; set; }


    }
}
