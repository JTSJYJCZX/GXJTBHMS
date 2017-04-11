using System;

namespace GxjtBHMS.Web.ViewModels.SafetyPreWarning
{
    public class SafetyPreWarningViewModel
    {
        public int Id { get; set; }
        public string  PointsNumber { get; set; }
        public DateTime Time { get; set; }
        public double MonitoringData { get; set; }
        public string Unit { get; set; }
        public double ThresholdValue { get; set; }
        public string SafetyPreWarningState { get; set; }
        public string Suggestion { get; set; }


        public double?[] SafetyPreWarnings { get; set; }
    }
}
