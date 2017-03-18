namespace GxjtBHMS.Service.Messaging.User
{
    public class ModifyPwdRequest
    {
        public string LoginId { get; set; }
        public string NewPassword { get; set; }
        public string OldPassword { get; set; }
    }
}
