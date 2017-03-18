using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Models.ThresholdValueSetting
{
    public class DisplaymentThresholdValueTable:ThresholdValueBase
    {
        /// <summary>
        /// 负标准值
        /// 负的一二三级阈值
        /// </summary>
        [Display(Name = "负标准值")]
        public double? NegativeStandardValue { get; set; }
        [Display(Name = "负一级阈值")]
        public double? NegativeFirstLevelThresholdValue { get; set; }
        [Display(Name = "负二级阈值")]
        public double? NegativeSecondLevelThresholdValue { get; set; }
        [Display(Name = "负三级阈值")]
        public double? NegativeThirdLevelThresholdValue { get; set; }
    }
}
