using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.ViewModels.AdminUser
{
    public class QueryUsersConditionView: UsersSearchConditionView
    {
        public QueryUsersConditionView()
        {
            CurrentPageIndex = WebConstants.FirstPageIndex;
        }
        public int CurrentPageIndex { get; set; }
    }
}