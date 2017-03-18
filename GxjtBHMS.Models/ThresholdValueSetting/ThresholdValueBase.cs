

using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Models.ThresholdValueSetting
{
    /// <summary>
    /// 阈值基类
    /// </summary>
    public class ThresholdValueBase : EntityBase<int>
    {
        [Display(Name ="测点编号")]
        public virtual MonitoringPointsNumber PointsNumber { get; set; }
        public int PointsNumberId { get; set; }

        /// <summary>
        /// 正标准值
        /// 正的一二三级阈值
        /// </summary>
        [Display(Name = "正标准值")]
        public double? PositiveStandardValue { get; set; }
        [Display(Name = "正一级阈值")]
        public double? PositiveFirstLevelThresholdValue { get; set; }
        [Display(Name = "正二级阈值")]
        public double? PositiveSecondLevelThresholdValue { get; set; }
        [Display(Name = "正三级阈值")]
        public double? PositiveThirdLevelThresholdValue { get; set; }

      
    }
}
