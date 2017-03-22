using NSubstitute;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace GxjtBHMS.Tests.ControllerTests
{
    static class FakeControllerHelper
    {
        public static void SetFakeControllerContext(this Controller controller)
        {
            var httpContext = FakeHttpContext();
            ControllerContext context = new ControllerContext(new RequestContext(httpContext, new RouteData()), controller);
            controller.ControllerContext = context;
        }
        public static HttpContextBase FakeHttpContext()
        {
            var context = Substitute.For<HttpContextBase>();
            var response = Substitute.For<HttpResponseBase>();
            context.Response.Returns(response);
            return context;
        }
    }
}
