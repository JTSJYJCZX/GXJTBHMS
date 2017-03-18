namespace GxjtBHMS.Service.Messaging.AdminUser
{
    public class UsersSearchRequest
    {
        public string UserName { get; set; }
        public int UserStateId { get; set; }
        public int CurrentPageIndex { get; set; }
    }
}
