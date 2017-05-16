namespace GxjtBHMS.Service.Messaging.AbnomalThresholdValueSetting
{
    public class AbnormalThresholdValueSettingRequest
    {
        public int TypeId { get; set; }
        public string TypeName { get; set; }
        public double? MaxLevelThresholdValue { get; set; }
        public double? MinLevelThresholdValue { get; set; }
    }
}
