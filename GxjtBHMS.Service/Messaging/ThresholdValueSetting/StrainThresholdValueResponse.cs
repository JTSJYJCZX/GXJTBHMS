using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class ConcreteStrainThresholdValueResponse :PagedResponse
    {
        public ConcreteStrainThresholdValueResponse()
        {
            ConcreteStrainThresholdValues = new List<ConcreteStrainThresholdValueTable>();
        }
        public IEnumerable<ConcreteStrainThresholdValueTable> ConcreteStrainThresholdValues { get; set; }
    }
}
