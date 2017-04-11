using System;

namespace GxjtBHMS.Models.SafetyPreWarningTable
{
    public abstract class SafetyPreWarningBaseModel: EntityBase<int>
    {
        public DateTime Time { get; set; }
        public double MonitoringData { get; set; }
        public double ThresholdValue { get; set; }//阈值
        public int PointsNumberId { get; set; }
        public virtual MonitoringPointsNumber PointsNumber { get; set; }
        public int ThresholdGradeId { get; set; }
        public virtual ThresholdGradeTable ThresholdGrade { get; set; }

    }
}
