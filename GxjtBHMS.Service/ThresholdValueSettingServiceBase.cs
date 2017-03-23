using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;

namespace GxjtBHMS.Service
{
    public abstract class ThresholdValueSettingServiceBase : ServiceBase
    {
        public abstract ConcreteStrainThresholdValueResponse GetThresholdValueListByPointsPosition(GetThresholdValueByPointsPositionSearchRequest req);

    }
}
