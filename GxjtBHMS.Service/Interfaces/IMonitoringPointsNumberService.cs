using GxjtBHMS.Service.Messaging.MonitoringDatas;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IMonitoringPointsNumberService
    {
        QueryAllMonitoringMonitoringPointsNumberResponse GetAllMonitoringPointsNumber();
        QueryMonitoringPointsNumberByPointsPositionIdResponse GetMonitoringPointsNumberByPointsPositionId(int ttId);
    }
}
