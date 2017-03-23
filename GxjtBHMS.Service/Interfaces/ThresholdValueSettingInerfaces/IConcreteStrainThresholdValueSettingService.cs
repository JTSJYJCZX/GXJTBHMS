using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IConcreteStrainThresholdValueSettingService
    {
        ConcreteStrainThresholdValueResponse GetThresholdValueListByPointsPosition(GetThresholdValueByPointsPositionSearchRequest req);
        ConcreteStrainThresholdValueResponse ModifyStrainThresholdValue(StrainThresholdValueSettingRequest model);
    }
}