using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class StrainThresholdValueResponse : PagedResponse
    {
        public StrainThresholdValueResponse()
        {
            StrainThresholdValues = new List<StrainThresholdValueTable>();
        }
        public IEnumerable<StrainThresholdValueTable> StrainThresholdValues { get; set; }
    }
}
