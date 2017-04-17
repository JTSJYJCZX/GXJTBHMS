namespace GxjtBHMS.Models
{
    public class MonitoringPointsPosition : EntityBase<int>
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public virtual MonitoringTestType TestType { get; set; }
        public int TestTypeId { get; set; }
    }
}
