using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.SqlServerDAL;
using System;
using System.Linq;
using System.Transactions;

namespace GxjtBHMS.Tests.IntegrationTests
{
    public abstract class DataBaseTest
    {
        public DataBaseTest()
        {
            //初始化ApplicationSettingsFactory
ApplicationSettingsFactory.InitApplicationSettingsFactory(new WebConfigApplicationSettings());
            ToPreventDBDoesNotExist();
        }

        /// <summary>
        /// 预先初始化数据库，防止无数据库的错误
        /// </summary>
        void ToPreventDBDoesNotExist()
        {
            using (BHMSContext ctx = new BHMSContext())
            {
                ctx.Users.Count();
            }
        }

        /// <summary>
        /// 包装事务回滚的数据访问代码
        /// </summary>
        /// <param name="action"></param>
        protected void WrapTransactionScope(Action action)
        {
            using (var scope = new TransactionScope())
            {
                action();
            }
        }
    }
}
