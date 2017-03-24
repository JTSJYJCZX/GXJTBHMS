using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Models.ThresholdValueSetting
{
    public abstract class ThresholdValueConditionBase : EntityBase<int>
    {
        [Display(Name = "测点编号")]
        public virtual MonitoringPointsNumber PointsNumber { get; set; }
        public int PointsNumberId { get; set; }
    }
}
