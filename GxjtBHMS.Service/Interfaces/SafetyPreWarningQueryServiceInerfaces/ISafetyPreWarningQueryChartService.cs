using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.SafetyPreWarning;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces.SafetyPreWarningQueryServiceInerfaces
{
    public interface ISafetyPreWarningQueryDetailService<T>
    {
        IEnumerable<SafetyPreWarningDetailQueryModel> GetSafetyPreWarningDetailSourceBy(IList<Func<T, bool>> ps);
    }
}
