using System;
using System.Collections.Generic;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IThresholdValueSettingService
    {
        ThresholdValueResponse GetThresholdValueBy(PointsNumberSearchRequest req);
        ThresholdValueResponse ModifyStrainThresholdValue(ThresholdValueSettingRequest model);
        PagedResponse GetPaginatorDatas(PointsNumberSearchRequest req);
    }
}