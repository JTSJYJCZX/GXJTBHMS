using GxjtBHMS.Service.ViewModels.AnomalousEventManagement;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces
{
    public interface IAnomalousEventManagementQueryService<T>
    {
        IEnumerable<AnomalousEventManagementModel> GetAnomalousEventManagementsSourceBy(IList<Func<T, bool>> ps, int currentPageIndex, int pageSize);
        IEnumerable<AnomalousEventManagementModel> GetAllAnomalousEventManagementsSourceBy(IList<Func<T, bool>> ps);
        long GetTotalResultCountBy(IList<Func<T, bool>> ps);
    }
}
