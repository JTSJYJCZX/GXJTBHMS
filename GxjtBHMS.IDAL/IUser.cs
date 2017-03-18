using GxjtBHMS.Models;
using System.Collections.Generic;
using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.IDAL
{
    public interface IUser: IReadOnlyRepository<User,int>,IRepository<User>
    {
        string GetLastUserName();
        int GetUserStateId(string name);
        IList<UserState> GetAllUserStates();
    }
}