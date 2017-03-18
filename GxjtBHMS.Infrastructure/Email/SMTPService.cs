using System.Net.Mail;
using System.Text;

namespace GxjtBHMS.Infrastructure.Email
{
    public class SMTPService : IEmailService
    {
        void IEmailService.SendMail(string from, string to, string subject, string body, bool isHtml)
        {
            MailMessage message = new MailMessage();
            message.Subject = subject;
            message.Body = body;
            message.IsBodyHtml = isHtml;
            message.From = new MailAddress(from);
            message.To.Add(new MailAddress(to));
            //内容编码  
            message.BodyEncoding = Encoding.UTF8;
            SmtpClient smtp = new SmtpClient();
            smtp.Send(message);
        }
    }
}
