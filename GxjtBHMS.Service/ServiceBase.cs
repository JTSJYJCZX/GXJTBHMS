using GxjtBHMS.Infrastructure.Logging;
using System;

namespace GxjtBHMS.Service
{
    public abstract class ServiceBase
    {
        protected void Log(string message,string strackTrace)
        {
            LoggingFactory.GetLogger().Log(message);
            LoggingFactory.GetLogger().Log(strackTrace);
        }

        protected void Log(Exception ex)
        {
            Log(ex.Message, ex.StackTrace);
        }
    }
}
