using GxjtBHMS.Services.ViewModels;
using GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas;
using GxjtBHMS.Web.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    [Authorize]
    public class BaseController : Controller
    {
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            base.OnActionExecuting(filterContext);

            if (Session[WebConstants.UserNickNameKey] == null)
            {
                if (Request.IsAjaxRequest())
                {
                    //向响应头添加特定会话过期键值对
                    Response.Headers.Add("sessionstatus", "timeout");
                }
                else
                {
                    string returnUrl = string.Concat("/", filterContext.ActionDescriptor.ControllerDescriptor.ControllerName, "/", filterContext.ActionDescriptor.ActionName);
                    filterContext.Result = Redirect("~/User/Login?ReturnUrl=" + HttpUtility.UrlEncode(returnUrl));
                }

            }
        }

        //protected override void OnException(ExceptionContext filterContext)
        //{
        //    if (Request.IsAjaxRequest())
        //    {
        //        filterContext.ExceptionHandled = true;
        //        filterContext.HttpContext.Response.Headers.Add("errorStatus", "500");
        //    }
        //    else
        //        base.OnException(filterContext);
        //}


        /// <summary>
        ///  提供将数据源转化为SelectListItem集合，具备请选择项，并保存在ViewData中的
        /// </summary>
        /// <param name="source">数据源</param>
        /// <param name="viewDataKey">viewData访问键</param>
        protected void SaveSelectListItemCollectionToViewData(IEnumerable<SelectListItemModel> source, string viewDataKey)
        {
            SaveSelectListItemCollectionToViewData(source, viewDataKey, true);
        }

        protected void SaveSelectListItemCollectionToViewData(IEnumerable<SelectListItemModel> source, string viewDataKey, bool hasPleaseChoiceItem)
        {
            var selectMonitoringPointsNumberListItemCollection = source != null ? source.Select(m => new SelectListItem { Text = m.Name, Value = m.Id.ToString() }) : new List<SelectListItem>();
            if (hasPleaseChoiceItem)
                ViewData[viewDataKey] = selectMonitoringPointsNumberListItemCollection.ToList().InsertPleaseChoiceSelectListItem();
            else
                ViewData[viewDataKey] = selectMonitoringPointsNumberListItemCollection;
        }

        protected void SaveSelectListItemCollectionToViewData(IEnumerable<SelectListItemModel> source, string viewDataKey, bool hasPleaseChoiceItem, int defaultChoiceId = 0)
        {
            var selectMonitoringPointsNumberListItemCollection = source != null ? source.Select(m => new SelectListItem { Text = m.Name, Value = m.Id.ToString() }) : new List<SelectListItem>();
            if (hasPleaseChoiceItem)
                ViewData[viewDataKey] = selectMonitoringPointsNumberListItemCollection.ToList().InsertPleaseChoiceSelectListItem();
            if (defaultChoiceId > 0)
            {
                var newselectMonitoringPointsNumberListItemArray = selectMonitoringPointsNumberListItemCollection.ToArray();
                newselectMonitoringPointsNumberListItemArray[defaultChoiceId - 1].Selected = true;
                var newSelectMonitoringPointsNumberListItemCollection = newselectMonitoringPointsNumberListItemArray.ToList();
                ViewData[viewDataKey] = newSelectMonitoringPointsNumberListItemCollection;
            }
            else
                ViewData[viewDataKey] = selectMonitoringPointsNumberListItemCollection;
        }
    }
}