using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Models
{
  public  class Basic_CableForceTable : MonitorDatasQueryConditionsModel
    {
        public double CableForce { get; set; }
        public double Frequency { get; set; }       
        public double Temperature { get; set; }

        public int ThresholdGradeId { get; set; }
        public virtual ThresholdGradeTable ThresholdGrade { get; set; }
    }
}
