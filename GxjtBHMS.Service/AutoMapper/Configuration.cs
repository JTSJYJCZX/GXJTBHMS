using AutoMapper;

namespace GxjtBHMS.Service.AutoMapper
{
    public class Configuration
    {
        public static void Configure()
        {
            Mapper.Initialize(cfg =>
            {
                //cfg.AddProfile<UserProfile>();
            });
        }

    }
}
