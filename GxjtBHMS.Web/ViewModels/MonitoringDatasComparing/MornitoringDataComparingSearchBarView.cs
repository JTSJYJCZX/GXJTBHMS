using GxjtBHMS.Web.ViewModels.MonitoringDatas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Web.ViewModels.MonitoringDatasComparing
{
    public class MornitoringDataComparingSearchBarView: MornitoringDataSearchBarBaseView
    {
        public int MornitoringTestTypeIdSecond { get; set; }
        public int MornitoringPointsPositionIdSecond { get; set; }
        public int[] MornitoringPointsNumberIdsSecond { get; set; }
    }
}