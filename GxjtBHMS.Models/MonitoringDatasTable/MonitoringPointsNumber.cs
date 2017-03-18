namespace GxjtBHMS.Models
{
    public class MonitoringPointsNumber : EntityBase<int>
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public virtual MonitoringPointsPosition PointsPosition { get; set; }
        public int PointsPositionId { get; set; }
        //public object PointsNumberId { get; set; }
    }
}

