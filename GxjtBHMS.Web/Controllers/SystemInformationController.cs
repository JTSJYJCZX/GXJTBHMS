using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    public class SystemInformationController : BaseController
    {
        // GET: SystemInformation
        public ActionResult Index()
        {
            return View();
        }
        [OutputCache(CacheProfile = "IndexProfile")]
        public ActionResult SystemDescription()
        {
            Response.Cache.SetOmitVaryStar(true);
            return View("SystemDescription");
        }
        [OutputCache(CacheProfile = "IndexProfile")]
        public ActionResult MonitoringPointsPositionAndNumber()
        {
            Response.Cache.SetOmitVaryStar(true);
            return View("MonitoringPointsPositionAndNumber");
        }
        [OutputCache(CacheProfile = "IndexProfile")]
        public ActionResult SystemFunctionIntroduction()
        {
            Response.Cache.SetOmitVaryStar(true);
            return View("SystemFunctionIntroduction");
        }
        [OutputCache(CacheProfile = "IndexProfile")]
        public ActionResult OperationManual()
        {
            Response.Cache.SetOmitVaryStar(true);
            return View();
        }
    }
}