using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.AdminUser;
using GxjtBHMS.Web.Filters;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.AdminUser;
using System.Linq;
using System.Web.Mvc;
using System.Collections.Generic;
using GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas;
using GxjtBHMS.Web.ViewModels;
using GxjtBHMS.Web.Models.Attributes;

namespace GxjtBHMS.Web.Controllers
{
    [CheckAdminLogin]
    public class AdminUserController
        : Controller
    {
        const string ListUserMessageActionName = "ListUserMessage";
        const string AdminSearchUserCacheProfile = "AdminSearchUserProfile";
        const string RegActionNameForHttpGet = "RegistUser";
        const string UsersSearchBarPartialViewName = "UsersSearchPartial";

        public AdminUserController(IAdminUserService adminUserService)
        {
            _adminUserService = adminUserService;
        }
        readonly IAdminUserService _adminUserService;

        public ActionResult RegistUser()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Reg()
        {
            if (ModelState.IsValid)
            {
                var resp = _adminUserService.RegUser();
                if (resp.Succeed)
                {
                    TempData[WebConstants.MessageColor] = StyleConstants.GreenColor;
                    TempData[WebConstants.Message] = $"账号{resp.LoginId}注册成功";
                }
                else
                {
                    TempData[WebConstants.MessageColor] = StyleConstants.RedColor;
                    TempData[WebConstants.Message] = resp.Message;
                }
            }
            return RedirectToAction(RegActionNameForHttpGet);
        }

        public ActionResult ListUserMessage()
        {
            var resp = _adminUserService.GetTotalPages();

            if (resp.Succeed)
            {
                ViewData["TotalPages"] = resp.TotalPages;
            }
            else
            {
                TempData[WebConstants.MessageColor] = StyleConstants.RedColor;
                TempData[WebConstants.Message] = resp.Message;
            }

            return View();
        }

        public ActionResult GetUserMessageList(QueryUsersConditionView conditions)
        {
            var req = new UsersSearchRequest
            {
                UserName = conditions.ContainsUserName,
                UserStateId = conditions.SearchUserStateId,
                CurrentPageIndex = conditions.CurrentPageIndex
            };
            var resp = _adminUserService.GetSearchUsersBy(req);
            var resultView = new UserSeachResultView();
            var allUserStateSelectedList = GetAllUserStatesSelectListDataSource();//获取所有的用户状态SelectList集合
            if (resp.Succeed)
            {
                SetAllUsersStateSelectedListToViewData(allUserStateSelectedList);//设置用户状态下拉列表的数据源到ViewData
                resultView.Users = resp.Users;//设置显示分页数据源
                resultView.PaginatorModel = new PaginatorModel { TotalPages = resp.TotalPages, CurrentPageIndex = conditions.CurrentPageIndex };
            }
            else
            {
                return Json(new { color = StyleConstants.RedColor, message = resp.Message }, JsonRequestBehavior.AllowGet);
            }
            return PartialView("ListUserMessagePartial", resultView);
        }

        [ChildActionOnly]
        public ActionResult GetUsersSearchPartial(UsersSearchConditionView conditions)
        {
            var allUserStateSelectedList = GetAllUserStatesSelectListDataSource();//获取所有的用户状态SelectList集合
            SetSearchBarUserStatesSelectedListToViewData(allUserStateSelectedList);//设置用户查询搜索栏用户状态下拉列表的数据源到ViewData
            return PartialView(UsersSearchBarPartialViewName, conditions);
        }

        void SetAllUsersStateSelectedListToViewData(IEnumerable<SelectListItem> source)
        {
            ViewData[WebConstants.AllUserStateSelectedListKey] = source;
        }

        IEnumerable<SelectListItem> GetAllUserStatesSelectListDataSource()
        {
            var allUsersStates = _adminUserService.GetAllUserStates();
            //把所有的会员状态列表转换为selectedListItem集合(视图中的DropDownList只认得该类型)
            var allUserStateSelectedList = allUsersStates.Select(
                m => new SelectListItem { Text = m.Name, Value = m.Id.ToString() });
            return allUserStateSelectedList;
        }


        void SetSearchBarUserStatesSelectedListToViewData(IEnumerable<SelectListItem> source)
        {
            var searchBarUserStateDropDownListDataSource = source.ToList();
            searchBarUserStateDropDownListDataSource.InsertPleaseChoiceSelectListItem();
            ViewData[WebConstants.SearchBarUserStateDropDownListDataSourceKey] = searchBarUserStateDropDownListDataSource;
        }

        [HttpPost]
        [MyValidateAntiForgeryToken]
        public ActionResult Edit(EditUserView model)
        {
            var req = new EditUserRequest { UserId = model.UserId, UserStateId = model.UserStateId };
            var resp = _adminUserService.ModifyUser(req);
            var message = resp.Message;
            var color = resp.Succeed ? StyleConstants.GreenColor : StyleConstants.RedColor;
            return Json(new { color, message });
        }

        [HttpPost]
        [MyValidateAntiForgeryToken]
        public ActionResult ResetPwd(int userId = 0)
        {
            var resp = _adminUserService.ResetUserPwd(userId);
            var message = resp.Message;
            var color = resp.Succeed ? StyleConstants.GreenColor : StyleConstants.RedColor;
            return Json(new { color, message });
        }
    }

}

