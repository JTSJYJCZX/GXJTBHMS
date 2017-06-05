namespace GxjtBHMS.Infrastructure.Configuration
{
    public interface IApplicationSettings
    {
        /// <summary>
        /// 日志配置文件路径
        /// </summary>
        string LoggerConfigurationPath { get; }

        /// <summary>
        /// 日志名称
        /// </summary>
        string LoggerName { get; }

        /// <summary>
        /// 发件人
        /// </summary>
        string EmailFrom { get; }

        /// <summary>
        /// 模型层程序集名称
        /// </summary>
        string ModelsLayerAssemblyString { get; }

        /// <summary>
        /// 加密策略类名
        /// </summary>
        string EncryptStrategyClassName { get; }

        /// <summary>
        /// 分页每页记录数
        /// </summary>
        int NumberOfResultsPrePage { get;}

        /// <summary>
        /// 管理员默认登录账号
        /// </summary>
        string AdminLoginId { get; }

        /// <summary>
        /// 数据库连接字符串名称
        /// </summary>
        string DBConnectionName { get; }

        /// <summary>
        /// 实时数据读取间隔时间，单位为秒
        /// </summary>
        int RealReadDatasInterval { get; }
    }
}
