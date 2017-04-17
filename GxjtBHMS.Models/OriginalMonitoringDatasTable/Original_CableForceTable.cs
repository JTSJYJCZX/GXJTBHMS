using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Models
{
  public  class Original_CableForceTable : MonitorDatasQueryConditionsModel
    {
        public double CableForce { get; set; }
        public double Frequency { get; set; }       
        public double Temperature { get; set; }
    }
}
