using System.Collections.Generic;

namespace GxjtBHMS.Models
{
    public class MonitoringTestType : EntityBase<int>
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public string Unit { get; set; }
        public virtual ICollection<MonitoringPointsPosition> MonitoringPointsPositions { get; set; }
    }
}
