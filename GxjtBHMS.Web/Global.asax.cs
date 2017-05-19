﻿using GxjtBHMS.DependencyInjection;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Infrastructure.Email;
using GxjtBHMS.Infrastructure.Logging;
using GxjtBHMS.Service.AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace GxjtBHMS.Web
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            //实现控制器依赖注入
            ControllerBuilder.Current.SetControllerFactory(new NinjectControllerFactory());
            //调用AutoMapper配置
            Configuration.Configure();
            //初始化ApplicationSettingsFactory
            ApplicationSettingsFactory.InitApplicationSettingsFactory(new WebConfigApplicationSettings());
            //初始化日志
            LoggingFactory.InitLogFactory(new Log4NetWebAdapter());
            //初始化邮件服务
            EmailServiceFactory.InitEmailServiceFactory(new SMTPService());
            //设置SQL缓存依赖的数据表
            //var connectionStringName = ApplicationSettingsFactory.GetApplicationSettings().DBConnectionName;
            //var connectionString = System.Configuration.ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;
            //SqlCacheDependencyAdmin.EnableNotifications(connectionString);
            //SqlCacheDependencyAdmin.EnableTableForNotifications(connectionString, new string[]
            //{
            //    "Users",
            //    "UserStates",
            //    "MonitoringTestTypes",
            //    "MonitoringPointsPositions",
            //    "MonitoringPointsNumbers"
            //});
        }

        protected void Application_End(object sender ,EventArgs e)
        {
            System.Threading.Thread.Sleep(2000);
            HitPage();

        }

        private void HitPage()
        {
            System.Net.WebClient client = new System.Net.WebClient();
            client.DownloadData("http://192.168.0.102");
        }
    }
}
