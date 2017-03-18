using GxjtBHMS.Models;
using GxjtBHMS.Service.ViewModels;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.ExtensionMethods.AdminUser
{
    static class UserServiceExtension
    {
        public static IEnumerable<UsersInfoView> ConvertToUsersInfoViewList(this IEnumerable<User> source)
        {
            return source.Select(m => new UsersInfoView
            {
                StateId = m.StateId,
                UserId = m.Id,
                UserName = m.UserName
            });
        }
    }
}
