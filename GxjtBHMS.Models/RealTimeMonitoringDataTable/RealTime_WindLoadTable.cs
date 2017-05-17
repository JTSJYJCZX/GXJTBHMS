namespace GxjtBHMS.Models.MonitoringDatasTable
{
    public class RealTime_WindLoadTable : MonitorDatasQueryConditionsModel
    {
        public double WindSpeed { get; set; }
        public double WindDirection { get; set; }
        public int ThresholdGradeId { get; set; }
        public virtual ThresholdGradeTable ThresholdGrade { get; set; }
    }
}