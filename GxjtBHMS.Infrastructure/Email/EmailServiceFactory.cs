namespace GxjtBHMS.Infrastructure.Email
{
    public class EmailServiceFactory
    {
        static IEmailService _instance;

        public static void InitEmailServiceFactory(IEmailService emailService)
        {
            _instance = emailService;
        }

        public static IEmailService GetEmailSevice()
        {
            return _instance;
        }
    }
}
