using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringPointsPosition;
using GxjtBHMS.Services.ViewModels;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas
{
    public static class MonitoringPointsPositionServiceExtensionMethods
    {
        public static IList<SelectListItem> ConvertToSelectListItemCollection(this IEnumerable<SelectListItemModel> source)
        {
            return source.Select(m => new SelectListItem { Text = m.Name, Value = m.Id.ToString() }).ToList();
        }
    }
}