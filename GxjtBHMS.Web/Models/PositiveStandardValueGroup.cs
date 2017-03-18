namespace GxjtBHMS.Web.Models
{
    /// <summary>
    /// 正阈值分组类
    /// </summary>
    public class PositiveStandardValueGroup
    {
        /// <summary>
        /// 正标准值
        /// </summary>
        public double? StandardValue { get; set; }
        /// <summary>
        /// 正一级阈值
        /// </summary>
        public double? FirstLevelThresholdValue { get; set; }
        /// <summary>
        /// 正二级阈值
        /// </summary>
        public double? SecondLevelThresholdValue { get; set; }
        /// <summary>
        /// 正三级阈值
        /// </summary>
        public double? ThirdLevelThresholdValue { get; set; }

        public double?[] ToArray()
        {
            return new double?[] {
                StandardValue,
                FirstLevelThresholdValue,
                SecondLevelThresholdValue,
                ThirdLevelThresholdValue
            };
        }
    }
}