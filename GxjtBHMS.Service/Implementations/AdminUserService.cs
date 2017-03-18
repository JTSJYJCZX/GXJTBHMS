using GxjtBHMS.Service.Interfaces;
using System;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Messaging.User;
using GxjtBHMS.Models.Encryption;
using GxjtBHMS.Infrastructure;
using GxjtBHMS.Service.UsersView;
using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.AdminUser;
using GxjtBHMS.Service.ExtensionMethods.AdminUser;
using GxjtBHMS.Infrastructure.Configuration;

namespace GxjtBHMS.Service.Implementations
{
    public class AdminUserService : ServiceBase, IAdminUserService
    {
        readonly IUser _userDAL;
        const int LoginIdPreLength = 4;
        const string NoRecordsMessage = "无记录！";

        public AdminUserService(IUser userDAL)
        {
            _userDAL = userDAL;
        }

        RegUserResponse IAdminUserService.RegUser()
        {
            var resp = new RegUserResponse();
            try
            {
                var newOne = CreateNewUser();
                _userDAL.Add(newOne);
                resp.Succeed = true;
                resp.LoginId = newOne.UserName;
            }
            catch (Exception ex)
            {
                resp.Message = $"账号注册失败";
                Log(ex);
            }
            return resp;
        }

        User CreateNewUser()
        {
            return new User
            {
                Password = EncryptContextFactory.GetContext().Encrypt(AppConstants.DefaultPlainTextPassword),
                UserName = GetUserName(),
                StateId = _userDAL.GetUserStateId(AppConstants.NormalState)
            };
        }

        string GetUserName()
        {
            var lastUserName = _userDAL.GetLastUserName();
            int userNumber = Convert.ToInt32(lastUserName.Substring(LoginIdPreLength)) + 1;
            return UserName.GetUser(userNumber);
        }

        IList<UserStateView> IAdminUserService.GetAllUserStates()
        {
            try
            {
                return _userDAL.GetAllUserStates().Select(m => new UserStateView { Id = m.Id, Name = m.StateName }).ToList();
            }
            catch (Exception ex)
            {
                Log(ex);
                return new List<UserStateView>();
            }
        }

        ResponseBase IAdminUserService.ModifyUser(EditUserRequest model)
        {
            var resp = new ResponseBase();
            try
            {
                var user = _userDAL.FindBy(m => m.Id == model.UserId).SingleOrDefault();
                user.StateId = model.UserStateId;
                _userDAL.Save(user);
                resp.Message = "保存成功";
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "编辑用户信息失败";
                Log(ex);
            }
            return resp;
        }
        ResponseBase IAdminUserService.ResetUserPwd(int userId)
        {
            var resp = new ResponseBase();
            try
            {
                var user = _userDAL.FindBy(m => m.Id == userId).SingleOrDefault();
                user.Password = EncryptContextFactory.GetContext().Encrypt(AppConstants.DefaultPlainTextPassword);
                _userDAL.Save(user);
                resp.Message = "重置密码成功";
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "重置密码失败";
                Log(ex);
            }
            return resp;
        }
        SearchUserResponse IAdminUserService.GetSearchUsersBy(UsersSearchRequest req)
        {
            var resp = new SearchUserResponse();
            IEnumerable<User> users = new List<User>();
            IList<Func<User, bool>> ps = new List<Func<User, bool>>();
            try
            {
                DealWithContainsUserName(req, ps);
                DealWithEqualsUserStateId(req, ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                users = _userDAL.FindBy(ps, req.CurrentPageIndex, numberOfResultsPrePage);

                if (HasNoSearchResult(users))
                {
                    resp.Message = NoRecordsMessage;
                }
                else
                {
                    resp.TotalResultCount = _userDAL.GetCountByContains(ps);
                    resp.Users = users.ConvertToUsersInfoViewList();
                    resp.Succeed = true;
                }
            }
            catch (Exception ex)
            {
                resp.Message = "搜索用户列表信息发生错误";
                Log(ex);
            }
            return resp;
        }

        bool HasNoSearchResult(IEnumerable<User> users)
        {
            return users.Count() == 0;
        }

        void DealWithEqualsUserStateId(UsersSearchRequest req, IList<Func<User, bool>> ps)
        {
            if (req.UserStateId > 0)
            {
                ps.Add(m => m.StateId == req.UserStateId);
            }
        }

        void DealWithContainsUserName(UsersSearchRequest req, IList<Func<User, bool>> ps)
        {
            if (!string.IsNullOrEmpty(req.UserName))
            {
                ps.Add(m => m.UserName.Contains(req.UserName));
            }
        }

        public PagedResponse GetTotalPages()
        {
            PagedResponse resp = new PagedResponse();
            try
            {
                resp.TotalResultCount = _userDAL.GetCountByContains();
                if (resp.TotalResultCount <= 0)
                {
                    resp.Message = "无记录!";
                }
                else
                {
                    resp.Succeed = true;
                }
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return resp;
        }
    }
}
