using GxjtBHMS.Service.ViewModels;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging.User
{
    public class GetUsersResponse : ResponseBase
    {
        public GetUsersResponse()
        {
            Users = new List<UsersInfoView>(); 
        }
        public IEnumerable<UsersInfoView> Users { get; set; }
    }
}
