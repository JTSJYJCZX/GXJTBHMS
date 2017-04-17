using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Models
{
   public class Basic_HumidityTable : MonitorDatasQueryConditionsModel
    {
        public double Humidity { get; set; }

        public int ThresholdGradeId { get; set; }
        public virtual ThresholdGradeTable ThresholdGrade { get; set; }
    }
    
}
