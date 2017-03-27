using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Service.Messaging.ThresholdValueSetting
{ 
    public class ThresholdValueContainNegativeModel: ThresholdValueWithoutNegativeModel
    {
        public double? NegativeFirstLevelThresholdValue { get; set; }
        public double? NegativeSecondLevelThresholdValue { get; set; }
    }
}