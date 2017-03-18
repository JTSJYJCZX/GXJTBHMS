using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public interface ICableForceDataRealTimeDisplayService
    {
        IEnumerable<RealTimeWarningDataModel> GetWarningCableForceDatasBy(int testTypeId);

    }
}
