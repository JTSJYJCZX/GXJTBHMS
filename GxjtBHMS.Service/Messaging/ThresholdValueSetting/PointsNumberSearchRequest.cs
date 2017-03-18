using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Service.Messaging
{
    public class PointsNumberSearchRequest
    {
        public string PointNumber{ get; set; }
        public int CurrentPageIndex { get; set; }
    }
}