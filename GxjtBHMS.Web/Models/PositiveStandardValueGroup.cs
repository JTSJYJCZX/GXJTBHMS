namespace GxjtBHMS.Web.Models
{
    /// <summary>
    /// 正阈值分组类
    /// </summary>
    public class PositiveStandardValueGroup
    {
        
        /// <summary>
        /// 正一级阈值
        /// </summary>
        public double? FirstLevelThresholdValue { get; set; }
        /// <summary>
        /// 正二级阈值
        /// </summary>
        public double? SecondLevelThresholdValue { get; set; }
        

        public double?[] ToArray()
        {
            return new double?[] {
                FirstLevelThresholdValue,
                SecondLevelThresholdValue,
            };
        }
    }
}