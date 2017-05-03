namespace GxjtBHMS.Models.AnomalousEventTable
{
    public class AnomalousEvent_TemperatureTable : MonitorDatasQueryConditionsModel
    {
        public double Temperature { get; set; }
        public int AnomalousEventReasonId { get; set; }
        public virtual AnomalousEventReasonTable AnomalousEventReason { get; set; }
    }
    
}
