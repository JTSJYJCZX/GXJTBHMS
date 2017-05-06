using System;

namespace GxjtBHMS.Models
{
    public abstract class MonitorDatasQueryConditionsModel:EntityBase<int>
    {
        public DateTime Time { get; set; }
        public int PointsNumberId { get; set; }
        public virtual MonitoringPointsNumber PointsNumber { get; set; }
        

    }
}
