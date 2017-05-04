namespace GxjtBHMS.Models.AnomalousEventTable
{
    public class AnomalousEvent_WindLoadTable : MonitorDatasQueryConditionsModel
    {
        public double WindSpeed { get; set; }
        public int AnomalousEventReasonId { get; set; }
        public virtual AnomalousEventReasonTable AnomalousEventReason { get; set; }
    }
}