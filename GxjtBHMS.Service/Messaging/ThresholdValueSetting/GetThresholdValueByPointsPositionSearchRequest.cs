using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Service.Messaging
{
    public class GetThresholdValueByPointsPositionSearchRequest
    {
        public int PointsPositionId{ get; set; }
        public string PointsNumber { get; set; }
    }
}