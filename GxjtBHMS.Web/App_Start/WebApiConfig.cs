using System.Web.Http;

namespace GxjtBHMS.Web
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API 配置和服务

            // Web API 路由
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
             name: "ReceviveDatasApi",
             routeTemplate: "api/ReceiveDatas/strains/",
             defaults: new { controller= "ReceiveStrainDatas" }
         );

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
        }
    }
}
