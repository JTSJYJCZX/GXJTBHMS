namespace GxjtBHMS.Web.Models
{
    /// <summary>
    /// 负阈值分组类
    /// </summary>
    public class NegativeStandardValueGroup
    {
        
        /// <summary>
        /// 负一级阈值
        /// </summary>
        public double? FirstLevelThresholdValue { get; set; }
        /// <summary>
        /// 负二级阈值
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