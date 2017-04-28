using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.MonitoringDatas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Web.ViewModels.AlarmDatas
{
    public class AlarmDatasSearchBarView
    {
        public int CurrentPageIndex { get; set; }
        public PaginatorModel PaginatorModel { get; set; }
        public int MornitoringTestTypeId { get; set; }
        public int MornitoringPointsPositionId { get; set; }
        public int[] MornitoringPointsNumberIds { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public AlarmDatasSearchBarView()
        {
            CurrentPageIndex = WebConstants.FirstPageIndex;
            StartTime = DateTime.Now.AddDays(-1);
            EndTime = DateTime.Now;
        }


    }
}