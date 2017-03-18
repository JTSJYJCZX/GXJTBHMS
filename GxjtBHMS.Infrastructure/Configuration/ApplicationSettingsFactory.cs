namespace GxjtBHMS.Infrastructure.Configuration
{
    public class ApplicationSettingsFactory
    {
        static IApplicationSettings _instance;
        public static void InitApplicationSettingsFactory(IApplicationSettings applicationSettins)
        {
            _instance = applicationSettins;
        }

        public static IApplicationSettings GetApplicationSettings()
        {
            return _instance;
        }
    }
}
