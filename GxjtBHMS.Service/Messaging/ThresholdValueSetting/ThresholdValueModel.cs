namespace GxjtBHMS.Service.Messaging.ThresholdValueSetting
{
    public class ThresholdValueModel
    {
        public string PointsNumberName { get; set; }
        public int PointsNumberId { get; set; }
        public double? PositiveFirstLevelThresholdValue { get; set; }
        public double? PositiveSecondLevelThresholdValue { get; set; }
    }
}