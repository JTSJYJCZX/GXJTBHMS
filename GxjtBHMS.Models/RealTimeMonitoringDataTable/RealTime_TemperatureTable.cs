﻿namespace GxjtBHMS.Models.RealTimeMonitoringDataTable
{
    public class RealTime_TemperatureTable : MonitorDatasQueryConditionsModel
    {
        public double Temperature { get; set; }

        public int ThresholdGradeId { get; set; }
        public virtual ThresholdGradeTable ThresholdGrade { get; set; }
    }
    
}
