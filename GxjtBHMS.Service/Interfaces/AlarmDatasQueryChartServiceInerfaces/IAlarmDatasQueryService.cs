using GxjtBHMS.Service.ViewModels.AlarmDatasModel;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces
{
    public interface IAlarmDatasQueryService<T>
    {
        IEnumerable<AlarmDatasModel> GetAlarmDatasSourceBy(IList<Func<T, bool>> ps, int currentPageIndex, int pageSize);

        long GetTotalResultCountBy(IList<Func<T, bool>> ps);
    }
}
