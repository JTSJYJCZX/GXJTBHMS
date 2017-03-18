using GxjtBHMS.Service.Messaging.User;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IUserService
    {
        LoginResponse Login(LoginRequest req);   
        ModifyPasswordResponse ModifyPwd(ModifyPwdRequest req);
    }
}