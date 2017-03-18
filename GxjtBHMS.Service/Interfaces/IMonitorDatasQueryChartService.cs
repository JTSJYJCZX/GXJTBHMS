﻿using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IMonitorDatasEigenvalueQueryChartService<T>
    {
        IEnumerable<ChartGroupDataModel> GetChartDataSourceBy(IList<Func<T, bool>> ps);
    }
}
