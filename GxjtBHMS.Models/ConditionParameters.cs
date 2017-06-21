using System;

namespace GxjtBHMS.Models
{
    public class ConditionParameters
    {
        public DateTime StarTime { get; set; }
        public DateTime EndTime { get; set; }
        public int[] PointsNumberIds { get; set; }
    }
}
