using GxjtBHMS.Infrastructure.Configuration;
using log4net;
using log4net.Config;
using System.IO;
using System.Web;

namespace GxjtBHMS.Infrastructure.Logging
{
    public class Log4NetWebAdapter : ILogger
    {
        readonly ILog _log;

        public Log4NetWebAdapter()
        {
            XmlConfigurator.ConfigureAndWatch(new FileInfo(HttpContext.Current.Server.MapPath("~/" + ApplicationSettingsFactory.GetApplicationSettings().LoggerConfigurationPath)));
            _log = LogManager.GetLogger(ApplicationSettingsFactory.GetApplicationSettings().LoggerName);
        }

        void ILogger.Log(string msg)
        {
            _log.Info(msg);
        }
    }
}
