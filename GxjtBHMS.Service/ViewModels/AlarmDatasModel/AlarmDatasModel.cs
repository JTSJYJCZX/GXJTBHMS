using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Service.ViewModels.AlarmDatasModel
{
   public class AlarmDatasModel
    {
        public string TestType { get; set; }
        public string PointsNumber { get; set; }
        public double MonitoringData { set; get; }
        public double ThresholdValue { set; get; }
        public string ThresholdGrade { set; get; }
        public string Time { get; set; }
    }
}
