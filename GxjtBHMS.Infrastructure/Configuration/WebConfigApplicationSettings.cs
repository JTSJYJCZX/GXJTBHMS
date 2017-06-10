using System.Configuration;

namespace GxjtBHMS.Infrastructure.Configuration
{
    public class WebConfigApplicationSettings : IApplicationSettings
    {
        int IApplicationSettings.RealReadDatasInterval
        {
            get
            {
                bool isSuccess;
                int result;
                isSuccess = int.TryParse(ConfigurationManager.AppSettings["AdminLoginId"], out result);
                if (!isSuccess)
                {
                    result = 5000;
                }
                return result;
            }

        }

        string IApplicationSettings.AdminLoginId
        {
            get
            {
                return ConfigurationManager.AppSettings["AdminLoginId"];
            }
        }

        string IApplicationSettings.DBConnectionName
        {
            get
            {
                return ConfigurationManager.AppSettings["DBConnectionName"];
            }
        }

        string IApplicationSettings.EmailFrom
        {
            get
            {
                return ConfigurationManager.AppSettings["EmailFrom"];
            }
        }

        string IApplicationSettings.EncryptStrategyClassName
        {
            get
            {
                return ConfigurationManager.AppSettings["EncryptStrategyClassName"];
            }
        }

        string IApplicationSettings.LoggerConfigurationPath
        {
            get
            {
                return ConfigurationManager.AppSettings["LoggerConfigurationPath"];
            }
        }

        string IApplicationSettings.LoggerName
        {
            get
            {
                return ConfigurationManager.AppSettings["LoggerName"];
            }
        }

        string IApplicationSettings.ModelsLayerAssemblyString
        {
            get
            {
                return ConfigurationManager.AppSettings["ModelsLayerAssemblyString"];
            }
        }

        int IApplicationSettings.NumberOfResultsPrePage
        {
            get
            {
                bool isSuccess;
                int result;
                isSuccess = int.TryParse(ConfigurationManager.AppSettings["NumberOfResultsPrePage"], out result);
                if (!isSuccess)
                {
                    result = 10;
                }
                return result;
            }
        }
    }
}
