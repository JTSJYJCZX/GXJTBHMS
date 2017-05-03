namespace GxjtBHMS.Models.AnomalousEventTable
{
    public class AnomalousEvent_DisplacementTable : MonitorDatasQueryConditionsModel
    {
        public double Displacement { get; set; }
        public int AnomalousEventReasonId { get; set; }
        public virtual AnomalousEventReasonTable AnomalousEventReason { get; set; }
    }
}
    
