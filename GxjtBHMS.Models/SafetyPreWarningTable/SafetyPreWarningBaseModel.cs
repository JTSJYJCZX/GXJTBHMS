using System;

namespace GxjtBHMS.Models.SafetyPreWarningTable
{
    public abstract class SafetyPreWarningBaseModel: EntityBase<int>
    {
        public DateTime Time { get; set; }
        public double MonitoringData { get; set; }
        public double ThresholdValue { get; set; }//阈值
        public string SafetyPreWarningState { get; set; }//预警状况       
        public string Suggestion { get; set; }//建议        
        public int PointsNumberId { get; set; }
        public virtual MonitoringPointsNumber PointsNumber { get; set; }
        
    }
}
