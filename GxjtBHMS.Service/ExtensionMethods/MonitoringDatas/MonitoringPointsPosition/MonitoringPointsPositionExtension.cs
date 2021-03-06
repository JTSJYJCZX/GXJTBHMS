﻿using GxjtBHMS.Models;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringPointsPosition;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.PointsPosition

{
    public static class MonitoringPointsPositionExtension
    {
        public static IEnumerable<MonitoringPointsPositionViewModel> ConvertToMonitoringTestTypeViewModelCollection(this IEnumerable<MonitoringPointsPosition> source)
        {
            return source.Select(m => new MonitoringPointsPositionViewModel { Name = m.Name, Id = m.Id, TestTypeId = m.TestTypeId });
        }
    }
}
