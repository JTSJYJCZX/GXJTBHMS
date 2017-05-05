using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Web.ViewModels.AnomalousEventManagement
{
    public class AnomalousEventManagementViewModel
    {
        public string TestType { get; set; }
        public string PointsPosition { get; set; }
        public string PointsNumber { get; set; }
        public string Time { get; set; }
        public string AnomalousEventReason { get; set; }
    }
}