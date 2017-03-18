namespace GxjtBHMS.Web.Models
{
    /// <summary>
    /// 负阈值分组类
    /// </summary>
    public class NegativeStandardValueGroup
    {
        /// <summary>
        /// 负标准值
        /// </summary>
        public double? StandardValue { get; set; }
        /// <summary>
        /// 负一级阈值
        /// </summary>
        public double? FirstLevelThresholdValue { get; set; }
        /// <summary>
        /// 负二级阈值
        /// </summary>
        public double? SecondLevelThresholdValue { get; set; }
        /// <summary>
        /// 负三级阈值
        /// </summary>
        public double? ThirdLevelThresholdValue { get; set; }

        public double?[] ToArray()
        {
            return new double?[] {
                StandardValue,
                FirstLevelThresholdValue,
                SecondLevelThresholdValue,
                ThirdLevelThresholdValue};
        }
    }
}