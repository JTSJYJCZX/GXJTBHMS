namespace GxjtBHMS.Models.RealTimeMonitoringDataTable
{
    public class RealTime_DisplacementTable : MonitorDatasQueryConditionsModel
    {
        public double Displacement { get; set; }

        public int ThresholdGradeId { get; set; }
        public virtual ThresholdGradeTable ThresholdGrade { get; set; }
    }
}
    
