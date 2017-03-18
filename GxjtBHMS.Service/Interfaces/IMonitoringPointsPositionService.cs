using System.Collections.Generic;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringPointsPosition;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IMonitoringPointsPositionService
    {
        QueryAllMonitoringPointsPositionResponse GetAllMonitoringPointsPosition();
        QueryMonitoringPointsPositionsByTestTypeIdResponse GetMonitoringPointsPositionsByTestTypeId(int ttId);
    }
}
