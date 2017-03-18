using System;
using System.Collections.Generic;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using System.Linq;
using GxjtBHMS.Infrastructure.Configuration;

namespace GxjtBHMS.SqlServerDAL
{
    public class UserDALImpl : Repository<User, int>, IUser
    {
        readonly string _adminName = ApplicationSettingsFactory.GetApplicationSettings().AdminLoginId;

        int IUser.GetUserStateId(string name)
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.UserStates.SingleOrDefault(m => m.StateName == name).Id;
            }
        }

        string IUser.GetLastUserName()
        {
            using (var ctx = new BHMSContext())
            {
                var id = ctx.Users.Max(m => m.Id);
                return ctx.Users.Find(id).UserName;
            }
        }

        IList<UserState> IUser.GetAllUserStates()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.UserStates.ToList();
            }
        }

        /// <summary>
        /// 排除查询管理员
        /// </summary>
        /// <returns>排除查询管理员的表达式</returns>
        Func<User, bool> ExcludeAdmin()
        {
            return m => m.UserName != _adminName;
        }

        public override int GetCountByContains(IList<Func<User, bool>> ps, params string[] navigationProperties)
        {
            ps.Add(ExcludeAdmin());
            return base.GetCountByContains(ps, navigationProperties);
        }

        public override int GetCountByContains(params string[] navigationProperties)
        {
            var ps = new List<Func<User, bool>>();
            return GetCountByContains(ps,navigationProperties);
        }


        public override IEnumerable<User> FindBy(IList<Func<User, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            ps.Add(ExcludeAdmin());
            var result = base.FindBy(ps, currentPageIndex, pageSize, navigationProperties);
            return result.OrderBy(m => m.UserName);
        }
    }
}