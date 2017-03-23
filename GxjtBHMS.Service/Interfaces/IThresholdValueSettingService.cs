﻿using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IThresholdValueSettingService
    {
       ConcreteStrainThresholdValueResponse GetThresholdValueBy(PointsNumberSearchRequest req);
        ConcreteStrainThresholdValueResponse ModifyStrainThresholdValue(StrainThresholdValueSettingRequest model);
        PagedResponse GetPaginatorDatas(PointsNumberSearchRequest req);
    }
}