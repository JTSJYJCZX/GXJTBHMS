using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Service.Messaging.ThresholdValueSetting
{ 
    public class ThresholdValueQueryConditionModel 
    {
        public int TestTypeId { get; set; }
        public int PointsPositionId { get; set; }
        public string  PointsName { get; set; }
    }
}