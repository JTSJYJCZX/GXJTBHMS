﻿using GxjtBHMS.Models.AbnormalThresholdValueSetting;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class AbnormalThresholdValueResponse : ResponseBase
    {
        public IEnumerable<AbnormalThresholdValueTable> AbnormalThresholdValue { get; set; }   

    }
}