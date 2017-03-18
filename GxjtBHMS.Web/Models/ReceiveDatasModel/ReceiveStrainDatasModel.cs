using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Web.Models.ReceiveDatasModel
{
    public class ReceiveStrainDatasModel
    {
        public double Strain { get; set; }
        public double Temperature { get; set; }
        public DateTime Time { get; set; }
        public int PointsNumberId { get; set; }

    }
}