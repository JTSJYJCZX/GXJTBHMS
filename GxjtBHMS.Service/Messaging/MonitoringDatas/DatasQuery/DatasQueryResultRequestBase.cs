using System;

namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class DatasQueryResultRequestBase
    {
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int[] PointsNumberIds { set; get; }   //表示整型的数组
        public int PointsPositionId { get; set; }
    }
}
