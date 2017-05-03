namespace GxjtBHMS.Models.AnomalousEventTable
{
    public class AnomalousEvent_HumidityTable : MonitorDatasQueryConditionsModel
    {
        public double Humidity { get; set; }
        public int AnomalousEventReasonId { get; set; }
        public virtual AnomalousEventReasonTable AnomalousEventReason { get; set; }
    }
    
}
