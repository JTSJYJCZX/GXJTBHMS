using GxjtBHMS.Service.Interfaces;
using System.Linq;
using GxjtBHMS.Service.Messaging.User;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models.Encryption;
using System;
using GxjtBHMS.Infrastructure.Logging;

namespace GxjtBHMS.Service.Implementations
{
    public class UserService : IUserService
    {
        readonly IUser _userDAL;

        public UserService(IUser userDAL)
        {
            _userDAL = userDAL;
        }

        LoginResponse IUserService.Login(LoginRequest req)
        {
            var resp = new LoginResponse();

            resp.Succeed = true;

            var loginId = req.LoginId.ToLower();

            var pwd = EncryptContextFactory.GetContext().Encrypt(req.LoginPassword);

            var user = _userDAL.FindBy(m => m.UserName == loginId && m.Password == pwd).SingleOrDefault();

            if (user == null)
            {
                resp.Message = "账号或密码不正确";
                resp.Succeed = false;
                return resp;
            }

            if (!user.IsActive())
            {
                resp.Message = "账号不可用";
                resp.Succeed = false;
            }

            return resp;
        }

        ModifyPasswordResponse IUserService.ModifyPwd(ModifyPwdRequest req)
        {
            var resp = new ModifyPasswordResponse();
            try
            {
                var pwd = EncryptContextFactory.GetContext().Encrypt(req.OldPassword);
                var model = _userDAL.FindBy(m => m.UserName == req.LoginId && m.Password == pwd).SingleOrDefault();
                if (model != null)
                {
                    model.Password = EncryptContextFactory.GetContext().Encrypt(req.NewPassword);
                    _userDAL.Save(model);
                    resp.Message = "密码修改成功！";
                    resp.Succeed = true;
                }
                else
                {
                    resp.Message = "原密码错误";
                }
            }
            catch (Exception ex)
            {
                LoggingFactory.GetLogger().Log(ex.Message);
                LoggingFactory.GetLogger().Log(ex.StackTrace);
                resp.Message = "修改密码失败！";
            }
            return resp;
        }

    }
}
