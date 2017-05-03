namespace GxjtBHMS.Models.AnomalousEventTable
{
    public class AnomalousEvent_SteelArchStrainTable : MonitorDatasQueryConditionsModel
    {
        public double Strain { get; set; }
        public int AnomalousEventReasonId { get; set; }
        public virtual AnomalousEventReasonTable AnomalousEventReason { get; set; }



    }
}