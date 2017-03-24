namespace GxjtBHMS.Service.Messaging.ThresholdValueSetting
{
    public class ThresholdValueSettingRequest
    {
        /// <summary>
        /// 负标准值
        /// 负的一二三级阈值
        /// </summary>

        public double? NegativeFirstLevelThresholdValue { get; set; }
        public double? NegativeSecondLevelThresholdValue { get; set; }
       

        public string PointsNumber { get; set; }
        public int PointsNumberId { get; set; }

        /// <summary>
        /// 正标准值
        /// 正的一二三级阈值
        /// </summary>

        public double? PositiveFirstLevelThresholdValue { get; set; }
        public double? PositiveSecondLevelThresholdValue { get; set; }



    }
}
