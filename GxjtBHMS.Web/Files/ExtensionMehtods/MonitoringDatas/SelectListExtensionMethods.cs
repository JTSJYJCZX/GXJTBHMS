using GxjtBHMS.Web.Models;
using System.Collections.Generic;
using System.Web.Mvc;

namespace GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas
{
    public static class SelectListExtensionMethods
    {
        public static IEnumerable<SelectListItem> InsertPleaseChoiceSelectListItem(this IList<SelectListItem> source){
            source.Insert(0, new SelectListItem() { Selected = true, Text = WebConstants.PleaseSelectMarkedWords, Value = "0" });
            return source;
        }
    }
}