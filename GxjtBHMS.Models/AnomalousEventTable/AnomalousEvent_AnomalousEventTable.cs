namespace GxjtBHMS.Models.AnomalousEventTable
{
    public class AnomalousEvent_AnomalousEventTable: MonitorDatasQueryConditionsModel
    {
        public double AnomalousData { get; set; }
        public int AnomalousEventReasonId { get; set; }
        public virtual AnomalousEventReasonTable AnomalousEventReason { get; set; }
    }
}
