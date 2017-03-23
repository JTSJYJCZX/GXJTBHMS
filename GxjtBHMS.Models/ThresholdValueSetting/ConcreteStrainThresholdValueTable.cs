using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Models.ThresholdValueSetting
{
    public  class ConcreteStrainThresholdValueTable:ThresholdValueBase
    {
        /// <summary>
        /// 负的一二级阈值
        /// </summary>
        [Display(Name = "负一级阈值")]
        public double? NegativeFirstLevelThresholdValue { get; set; }
        [Display(Name = "负二级阈值")]
        public double? NegativeSecondLevelThresholdValue { get; set; }
        
    }
}
