﻿using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class ThresholdValueResponse :PagedResponse
    {
        public IEnumerable<ThresholdValueIncludeNegativeModel> ThresholdValuesIncludeNegative { get; set; }
    }
}
