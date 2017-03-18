using System.Net;
using System.Web.Helpers;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Models.Attributes
{
    public class MyValidateAntiForgeryToken : AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            var request = filterContext.HttpContext.Request;
            if (request.HttpMethod == WebRequestMethods.Http.Post)
            {
                if (request.IsAjaxRequest())
                {
                    var antiForgeryCookie = request.Cookies[AntiForgeryConfig.CookieName];
                    var cookieValue = antiForgeryCookie != null
                        ? antiForgeryCookie.Value
                        : null;
                    //从cookies 和 Headers 中 验证防伪标记
                    AntiForgery.Validate(cookieValue, request.Headers["__RequestVerificationToken"]);
                }
                else
                {
                    new ValidateAntiForgeryTokenAttribute()
                        .OnAuthorization(filterContext);
                }
            }
        }
    }
}