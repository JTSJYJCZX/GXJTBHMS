using GxjtBHMS.Models;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.TestType;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.TestTypes
{
    public static class MonitoringTestTypeExtension
    {
        public static IEnumerable<MonitoringTestTypeViewModel> ConvertToMonitoringTestTypeViewModelCollection(this IEnumerable<MonitoringTestType> source)
        {
            return source.Select(m => new MonitoringTestTypeViewModel { Name = m.Name, Id = m.Id });
        }
    }
}
