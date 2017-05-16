using System;

namespace GxjtBHMS.Infrastructure.CookieStorage
{
    public interface ICookieStorageService
    {
        void Save(string key,string value,DateTime expires);

    }
}
