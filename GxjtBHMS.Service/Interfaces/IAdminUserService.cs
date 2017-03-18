using System.Collections.Generic;
using GxjtBHMS.Service.Messaging.User;
using GxjtBHMS.Service.UsersView;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.AdminUser;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IAdminUserService
    {
        RegUserResponse RegUser();
        IList<UserStateView> GetAllUserStates();
        ResponseBase ModifyUser(EditUserRequest model);
        SearchUserResponse GetSearchUsersBy(UsersSearchRequest req);
        ResponseBase ResetUserPwd(int userId);
        PagedResponse GetTotalPages();
    }
}
