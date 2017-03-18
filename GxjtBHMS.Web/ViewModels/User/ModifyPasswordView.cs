using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Web.ViewModels.User
{
    public class ModifyPasswordView
    {
        [Required(ErrorMessage = "{0}必须填写！")]
        [DisplayName("密码/Password")]
        [StringLength(12, MinimumLength = 6, ErrorMessage = "密码长度为6-12位！")]
        public string Password { get; set; }

        [DisplayName("新密码/Password")]
        [StringLength(12, MinimumLength = 6, ErrorMessage = "密码长度为6-12位！")]
        [Required(ErrorMessage = "{0}必须填写！")]
        public string NewPassword { get; set; }

        [DisplayName("确认新密码/Password")]
        [Compare("NewPassword", ErrorMessage = "两次输入密码不一致！")]
        public string ConfirmPassword { get; set; }
    }
}