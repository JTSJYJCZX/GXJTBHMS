using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Models.ThresholdValueSetting
{
    public abstract class ThresholdValueConditionBase : EntityBase<int>
    {
        [Display(Name = "测点编号")]
        public virtual MonitoringPointsNumber PointsNumber { get; set; }
        public int PointsNumberId { get; set; }
    }
}
