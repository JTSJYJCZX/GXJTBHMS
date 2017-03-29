using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Service.Messaging.AbnomalThresholdValueSetting
{
    public class AbnormalThresholdValueSettingRequest
    {
        public int TypeId { get; set; }
        public string TypeName { get; set; }
        public double? MaxLevelThresholdValue { get; set; }
        public double? MinLevelThresholdValue { get; set; }
    }
}
