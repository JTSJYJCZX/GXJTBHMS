using GxjtBHMS.Service.Messaging.MonitoringDatas;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IMonitoringPointsPositionService
    {
        QueryAllMonitoringPointsPositionResponse GetAllMonitoringPointsPosition();
        QueryMonitoringPointsPositionsByTestTypeIdResponse GetMonitoringPointsPositionsByTestTypeId(int ttId);
        string CreateDownloadFileMixedName(int positionId, string dataType);
    }
}
