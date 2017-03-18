using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace GxjtBHMS.Web.ViewModels.User
{
    public class LoginView
    {
        [Required(ErrorMessage ="{0}必须填写！")]
        [DisplayName("账号/UserName")]
        public string LoginId { get;  set; }

        [Required(ErrorMessage = "{0}必须填写！")]
        [DisplayName("密码/Password")]
        [StringLength(12,MinimumLength =6,ErrorMessage ="密码长度为6-12位！")]
        public string Password { get;  set; }

    }
}