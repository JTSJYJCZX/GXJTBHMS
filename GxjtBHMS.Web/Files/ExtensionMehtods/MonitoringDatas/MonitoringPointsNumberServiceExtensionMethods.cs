using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringPointsNumber;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas
{
    public static class MonitoringPointsNumberServiceExtensionMethods
    {
        public static IList<SelectListItem> ConvertToSelectListItemCollection(this IEnumerable<MonitoringPointsNumberViewModel> source)
        {
            return source.Select(m => new SelectListItem { Text = m.Name, Value = m.Id.ToString() }).ToList();
        }
    }
}