using GxjtBHMS.Models.AnomalousEventTable;
using GxjtBHMS.Service.ViewModels.AnomalousEventManagement;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces
{
    public interface IAnomalousEventManagementService
    {
        IEnumerable<AnomalousEventManagementModel> GetAnomalousEventManagementsSourceBy(IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps, int currentPageIndex, int pageSize);
        IEnumerable<AnomalousEventManagementModel> GetAnomalousEventSourceBy(IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps);

        long GetTotalResultCountBy(IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps);
    }
}
