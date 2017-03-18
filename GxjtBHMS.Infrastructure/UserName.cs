using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
