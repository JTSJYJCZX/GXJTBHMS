

using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Models.ThresholdValueSetting
{
    /// <summary>
    /// 阈值基类
    /// </summary>
    public class ContainNegativeThresholdValueBase : ThresholdValueConditionBase
    {
        /// <summary>
        /// 正的一二级阈值
        /// </summary>
        
        [Display(Name = "正一级阈值")]
        public double? PositiveFirstLevelThresholdValue { get; set; }
        [Display(Name = "正二级阈值")]
        public double? PositiveSecondLevelThresholdValue { get; set; }

        /// <summary>
        /// 负的一二级阈值
        /// </summary>
        [Display(Name = "负一级阈值")]
        public double? NegativeFirstLevelThresholdValue { get; set; }
        [Display(Name = "负二级阈值")]
        public double? NegativeSecondLevelThresholdValue { get; set; }

    }
}
