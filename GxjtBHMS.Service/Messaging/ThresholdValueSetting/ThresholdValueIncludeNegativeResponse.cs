using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class ThresholdValueIncludeNegativeResponse :PagedResponse
    {
        public IEnumerable<ThresholdValueContainNegativeModel> ThresholdValueContainNegative { get; set; }
        public bool IsContainNegative { get; set; }
    }
}
