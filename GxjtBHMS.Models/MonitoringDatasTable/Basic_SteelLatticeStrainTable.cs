namespace GxjtBHMS.Models.MonitoringDatasTable
{
    public class Basic_SteelLatticeStrainTable :MonitorDatasQueryConditionsModel
    {
        public double Strain { get; set; }
        public double Temperature { get; set; }

        public int ThresholdGradeId { get; set; }
        public virtual ThresholdGradeTable ThresholdGrade { get; set; }
    }
}