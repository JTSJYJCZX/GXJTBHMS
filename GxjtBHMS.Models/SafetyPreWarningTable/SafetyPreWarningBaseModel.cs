using System;

namespace GxjtBHMS.Models.SafetyPreWarningTable
{
    public abstract class SafetyPreWarningBaseModel: MonitorDatasQueryConditionsModel
    {
        public double MonitoringData { get; set; }
        public double ThresholdValue { get; set; }//阈值

        public int ThresholdGradeId { get; set; }
        public virtual ThresholdGradeTable ThresholdGrade { get; set; }

    }
}
