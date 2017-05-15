namespace GxjtBHMS.Infrastructure
{
    public class UserName
    {
        public static string GetUser(int userNumber)
        {
            return string.Concat(AppConstants.LoginIdPrefix, userNumber.ToString(AppConstants.LoginIdFormat));
        }
    }


}
