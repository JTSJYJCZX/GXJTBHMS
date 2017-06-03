using GxjtBHMS.Web.Models;
using System;

namespace GxjtBHMS.Web.ViewModels.AnomalousEventManagement
{
    public class AnomalousEventsQueryConditionView
    {
        public AnomalousEventsQueryConditionView()
        {
            CurrentPageIndex = WebConstants.FirstPageIndex;
            StartTime = DateTime.Now.AddDays(-1);
            EndTime = DateTime.Now;
        }
        public int CurrentPageIndex { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int PointsPositionId { get; set; }
        public int TestTypeId { get; set; }
    }
}