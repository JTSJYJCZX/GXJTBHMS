using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IThresholdValueSettingService
    {
       StrainThresholdValueResponse GetThresholdValueBy(PointsNumberSearchRequest req);
        StrainThresholdValueResponse ModifyStrainThresholdValue(StrainThresholdValueSettingRequest model);
        PagedResponse GetPaginatorDatas(PointsNumberSearchRequest req);
    }
}