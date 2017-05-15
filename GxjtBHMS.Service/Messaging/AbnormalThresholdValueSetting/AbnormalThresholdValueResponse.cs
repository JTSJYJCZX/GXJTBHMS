using GxjtBHMS.Models.AbnormalThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class AbnormalThresholdValueResponse : ResponseBase
    {
        public IEnumerable<Abnormal_ThresholdValueTable> AbnormalThresholdValue { get; set; }   

    }
}
