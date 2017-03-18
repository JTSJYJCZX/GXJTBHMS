using GxjtBHMS.Infrastructure.Configuration;
using System.Web.Mvc;
using System.Web.Security;

namespace GxjtBHMS.Web.Filters
{
    /// <summary>
    /// 检查是否是管理员登录过滤器
    /// </summary>
    public class CheckAdminLogin : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var userName = filterContext.HttpContext.User.Identity.Name;//获取用户标识名称
            if (!userName.Equals(ApplicationSettingsFactory.GetApplicationSettings().AdminLoginId))
            {
                FormsAuthentication.SignOut();//验证票据注销
                filterContext.Result = new RedirectResult(FormsAuthentication.LoginUrl);//设置重定向到登录页面
            }
            base.OnActionExecuting(filterContext);
        }
    }
}