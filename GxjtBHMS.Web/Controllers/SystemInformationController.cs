using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    public class SystemInformationController : Controller
    {
        // GET: SystemInformation
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult SystemDescription()
        {
            return View("SystemDescription");
        }
        public ActionResult MonitoringPointsPositionAndNumber()
        {
            return View("MonitoringPointsPositionAndNumber");
        }
        public ActionResult SystemFunctionIntroduction()
        {
            return View("SystemFunctionIntroduction");
        }

    }
}