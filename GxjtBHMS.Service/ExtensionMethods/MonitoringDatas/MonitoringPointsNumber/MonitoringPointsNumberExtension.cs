using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringPointsNumber;
using GxjtBHMS.Models;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.PointsNumbers
{
    public static class MonitoringPointsNumberExtension
    {
        public static IEnumerable<MonitoringPointsNumberViewModel> ConvertToMonitoringTestTypeViewModelCollection(this IEnumerable<MonitoringPointsNumber> source)
        {
            return source.Select(m => new MonitoringPointsNumberViewModel { Name = m.Name, Id = m.Id });
        }
    }

}
