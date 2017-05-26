using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    public class ErrorsController : BaseController
    {
        public ActionResult ServerError()
        {
            return View();
        }
    }
}