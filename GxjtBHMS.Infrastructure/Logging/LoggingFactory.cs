namespace GxjtBHMS.Infrastructure.Logging
{
    public class LoggingFactory
    {
        static ILogger _instance;

        public static void InitLogFactory(ILogger logger)
        {
            _instance = logger;
        }

        public static ILogger GetLogger()
        {
            return _instance;
        }
    }
}
