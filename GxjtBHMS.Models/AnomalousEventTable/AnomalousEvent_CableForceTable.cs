namespace GxjtBHMS.Models.AnomalousEventTable
{
    public  class AnomalousEvent_CableForceTable : MonitorDatasQueryConditionsModel
    {
        public double CableForce { get; set; }
        public int AnomalousEventReasonId { get; set; }
        public virtual AnomalousEventReasonTable AnomalousEventReason { get; set; }
    }
}
