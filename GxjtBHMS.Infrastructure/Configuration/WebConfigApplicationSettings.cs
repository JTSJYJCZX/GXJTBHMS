using System.Configuration;

namespace GxjtBHMS.Infrastructure.Configuration
{
    public class WebConfigApplicationSettings : IApplicationSettings
    {
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
                isSuccess = int.TryParse(ConfigurationManager.AppSettings["NumberOfResultsPrePage"],out result);
                return result;
            }
        }
    }
}
