using GxjtBHMS.Service.ViewModels;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Web.ViewModels.AdminUser
{
    /// <summary>
    /// 用户查询结果视图类
    /// </summary>
    public class UserSeachResultView
    {
        public PaginatorModel PaginatorModel { get; set; }

        public UserSeachResultView()
        {
            Users = new List<UsersInfoView>();
        }
        public IEnumerable<UsersInfoView> Users { get; set; }
        public bool HasSearchResult { get { return Users.Count() != 0; } }
    }
}