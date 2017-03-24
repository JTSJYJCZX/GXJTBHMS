using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;

namespace GxjtBHMS.Service
{
    public abstract class ThresholdValueSettingServiceAbstractBase : ServiceBase
    {
        public abstract ThresholdValueResponse GetThresholdValueListByPointsPosition(GetThresholdValueByPointsPositionSearchRequest req);
        public abstract ThresholdValueResponse ModifyThresholdValue(ThresholdValueSettingRequest req);
    }
}
