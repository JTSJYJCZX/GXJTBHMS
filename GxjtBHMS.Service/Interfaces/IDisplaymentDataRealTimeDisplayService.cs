using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IDisplaymentDataRealTimeDisplayService
    {
       IEnumerable<IncludeSectionWarningColorDataModel> GetWarningDisplaymentDatasBy(int testTypeId);
    }
}
