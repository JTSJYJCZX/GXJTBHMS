﻿namespace GxjtBHMS.Models.RealTimeMonitoringDataTable
{
    public  class RealTime_CableForceTable : MonitorDatasQueryConditionsModel
    {
        public double CableForce { get; set; }
        public double Frequency { get; set; }       
        public double Temperature { get; set; }

        public int ThresholdGradeId { get; set; }
        public virtual ThresholdGradeTable ThresholdGrade { get; set; }
    }
}
