using System;

namespace GxjtBHMS.Web.ViewModels.MonitoringDatas
{
    public class MornitoringDataSearchBarBaseView
    {
        public int MornitoringTestTypeId { get; set; }
        public int MornitoringPointsPositionId { get; set; }
        public int[] MornitoringPointsNumberIds { get; set; }
        public DateTime StartTime { get; set; }      
        public DateTime EndTime { get; set; }
        public MornitoringDataSearchBarBaseView()
        {
            StartTime = DateTime.Now.AddDays(-1);
            EndTime = DateTime.Now;
        }
    }
}