using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public  interface IHumidityDataRealTimeDisplayService
    {
        IEnumerable<RealTimeWarningDataModel> GetWarningHumidityDatasBy(int testTypeId);
    }
}
