using GxjtBHMS.Infrastructure.Configuration;
using System.Reflection;

namespace GxjtBHMS.Models.Encryption
{
    public class EncryptContextFactory
    {
        static EncryptContext _instance;
        public static EncryptContext GetContext()
        {
            if (_instance == null)
            {
                string assemblyString = ApplicationSettingsFactory.GetApplicationSettings().ModelsLayerAssemblyString;
                string ClassName = ApplicationSettingsFactory.GetApplicationSettings().EncryptStrategyClassName;
                var strategy = (AppEncryptionStrategy)Assembly.Load(assemblyString).CreateInstance(string.Concat(assemblyString,".", ClassName));
                _instance = new EncryptContext(strategy);
            }
            return _instance;
        }
    }
}
