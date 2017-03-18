using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Service.Interfaces
{
    public interface ITemperatureDataRealTimeDisplayService
    {
        IEnumerable<RealTimeWarningDataModel> GetWarningTemperatureDatasBy(int testTypeId);

    }
}
