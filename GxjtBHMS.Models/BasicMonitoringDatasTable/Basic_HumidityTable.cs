namespace GxjtBHMS.Models
{
    public class Basic_HumidityTable : MonitorDatasQueryConditionsModel
    {
        public double Humidity { get; set; }
        public int ThresholdGradeId { get; set; }
        public virtual ThresholdGradeTable ThresholdGrade { get; set; }
    }
    
}
