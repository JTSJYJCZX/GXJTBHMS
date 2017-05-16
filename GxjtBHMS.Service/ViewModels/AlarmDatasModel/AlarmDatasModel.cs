namespace GxjtBHMS.Service.ViewModels.AlarmDatasModel
{
    public class AlarmDatasModel
    {
        public string TestType { get; set; }
        public string PointsPosition { get; set; }
        public string PointsNumber { get; set; }
        public double MonitoringData { set; get; }
        public double ThresholdValue { set; get; }
        public string ThresholdGrade { set; get; }
        public string Time { get; set; }
        public string Unit { get; set; }

    }
}
