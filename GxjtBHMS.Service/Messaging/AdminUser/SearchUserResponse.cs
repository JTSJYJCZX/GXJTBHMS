using System.Collections.Generic;
using GxjtBHMS.Service.ViewModels;

namespace GxjtBHMS.Service.Messaging.AdminUser
{
    public class SearchUserResponse : PagedResponse
    {
        public SearchUserResponse()
        {
            Users = new List<UsersInfoView>();
        }
        /// <summary>
        /// 当前搜索的分页数据源
        /// </summary>
        public IEnumerable<UsersInfoView> Users { get; set; }
    }
}
