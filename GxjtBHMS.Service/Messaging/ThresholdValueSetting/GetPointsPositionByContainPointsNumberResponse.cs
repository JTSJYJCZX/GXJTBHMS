using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class GetPointsPositionByContainPointsNumberResponse : PagedResponse
    {
        public IEnumerable<int> PointsPositionsId { get; set; }

    }
}
