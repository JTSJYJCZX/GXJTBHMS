using System.Web.Routing;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.Shared
{
    public class SimplePagedViewModel
    {
        public SimplePagedViewModel()
        {
            RouteValues = new RouteValueDictionary();
            FirstPageDisplayStyleSetting = new Dictionary<string, object>();
            LastPageDisplayStyleSetting = new Dictionary<string, object>();
        }
        public int CurrentPageIndex { get; set; }
        public int NumberOfResultsPrePage { get; set; }
        public long TotalPages { get; set; }
        public long TotalResultCount { get; set; }
        public IDictionary<string, object> LastPageDisplayStyleSetting { get; set; }
        public IDictionary<string,object> FirstPageDisplayStyleSetting { get; set; }
        public string ActionName { get; set; }
        public string ControllerName { get; set; }

        internal RouteValueDictionary RouteValues { get; set; }

        public RouteValueDictionary PrePageRouteValues
        {
            get
            {
                RouteValues[nameof(CurrentPageIndex)] = CurrentPageIndex - 1;
                return RouteValues;
            }
        }

        public RouteValueDictionary NextPageRouteValues
        {
            get
            {
                RouteValues[nameof(CurrentPageIndex)] = CurrentPageIndex + 1;
                return RouteValues;
            }
        }

        public RouteValueDictionary FirstPageRouteValues
        {
            get
            {
                RouteValues[nameof(CurrentPageIndex)] = 1;
                return RouteValues;
            }
        }

        public RouteValueDictionary LastPageRouteValues
        {
            get
            {
                RouteValues[nameof(CurrentPageIndex)] = TotalPages;
                return RouteValues;
            }
        }

    }
}