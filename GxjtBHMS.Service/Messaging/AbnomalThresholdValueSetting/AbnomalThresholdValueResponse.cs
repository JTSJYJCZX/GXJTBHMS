using GxjtBHMS.Models.AbnormalThresholdValueSetting;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class AbnomalThresholdValueResponse : ResponseBase
    {
        public IEnumerable<AbnormalThresholdValueTable> AbnomalThresholdValue { get; set; }   

    }
}
