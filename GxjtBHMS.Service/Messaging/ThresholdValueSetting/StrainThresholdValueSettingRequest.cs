namespace GxjtBHMS.Service.Messaging.ThresholdValueSetting
{
    public class StrainThresholdValueSettingRequest
    {
        /// <summary>
        /// 负标准值
        /// 负的一二三级阈值
        /// </summary>

        public double? NegativeStandardValue { get; set; }
        public double? NegativeFirstLevelThresholdValue { get; set; }
        public double? NegativeSecondLevelThresholdValue { get; set; }
        public double? NegativeThirdLevelThresholdValue { get; set; }

        public string PointsNumber { get; set; }
        public int PointsNumberId { get; set; }

        /// <summary>
        /// 正标准值
        /// 正的一二三级阈值
        /// </summary>
        public double? PositiveStandardValue { get; set; }
        public double? PositiveFirstLevelThresholdValue { get; set; }
        public double? PositiveSecondLevelThresholdValue { get; set; }
        public double? PositiveThirdLevelThresholdValue { get; set; }


    }
}
