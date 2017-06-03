using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.User;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.User;
using System.Web.Mvc;
using System.Web.Security;

namespace GxjtBHMS.Web.Controllers
{
    public class UserController : Controller
    {
        readonly IUserService _userService;
        const string IndexActionName = "Index";
        const string HomeControllerName = "Home";
        const string UserLoginActionName = "Login";
        const string LoginCacheProfile = "loginProfile";
        const string LoginActionViewName = "UserLogin";
        const string EditUserInfoActionName = "EditUserInfo";

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [OutputCache(CacheProfile = "IndexProfile")]
        [ActionName(UserLoginActionName)]
        [AllowAnonymous]//允许匿名访问
        public ActionResult UserLogin(string returnUrl)
        {
            ViewData[nameof(returnUrl)] = returnUrl;
            return View(LoginActionViewName);
        }

        [ActionName(UserLoginActionName)]
        [HttpPost]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]//允许匿名访问
        //动作里面的参数是由网页传输过来
        public ActionResult UserLogin(LoginView model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                var req = new LoginRequest();
                req.LoginId = model.LoginId;
                req.LoginPassword = model.Password;

                var resp = _userService.Login(req);
                if (resp.Succeed)
                {
                    Session[WebConstants.UserNickNameKey] = req.LoginId;
                    //发放验证票据
                    FormsAuthentication.SetAuthCookie(model.LoginId, false);//为提供的用户名创建一个身份验证票证，并将该票证添加到响应的 Cookie 集合中或 URL 中（如果使用的是无 Cookie 身份验证）。如果 CookiesSupported 为 false，则 SetAuthCookie 方法会将 Forms 身份验证票证添加到 Cookie 集合或 URL 中。此 Forms 身份验证票证为浏览器发出的下一个请求提供 Forms 身份验证信息。有了 Forms 身份验证，当您想要对用户进行身份验证但仍然希望使用重定向保留对导航的控制时，就可以使用 SetAuthCookie 方法。
                    if (!string.IsNullOrEmpty(returnUrl))
                    {
                        return Redirect(returnUrl);
                    }
                    return RedirectToAction(IndexActionName, HomeControllerName);
                }
                ViewData[WebConstants.MessageKey] = resp.Message;
            }
            return View(LoginActionViewName, model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Logout()
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            return Redirect(FormsAuthentication.LoginUrl);
        }

        public ActionResult EditUserInfo()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditUserInfo(ModifyPasswordView model)
        {
            if (ModelState.IsValid)
            {
                var req = new ModifyPwdRequest
                {
                    LoginId = GetLoginId(),
                    OldPassword = model.Password,
                    NewPassword = model.NewPassword
                };
                var resp = _userService.ModifyPwd(req);
                if (resp.Succeed)
                {
                    TempData[WebConstants.MessageKey] = resp.Message;
                    return RedirectToAction(EditUserInfoActionName);
                }
                ModelState.AddModelError(string.Empty, resp.Message);
            }
            return View(model);
        }

        string GetLoginId()
        {
            return Session[WebConstants.UserNickNameKey].ToString();
        }
    }
};