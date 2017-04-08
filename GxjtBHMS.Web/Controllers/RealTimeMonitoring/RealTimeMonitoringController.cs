using GxjtBHMS.Service.Interfaces;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers.RealTimeMonitoring
{
    public class RealTimeMonitoringController : Controller
    {
        public ActionResult SteelArchStrainDatasRealTimeMonitoring()
        {
            return View();
        }

        public ActionResult SteelLatticeStrainDatasRealTimeMonitoring()
        {
            return View();
        }

        public ActionResult ConcreteStrainStrainDatasRealTimeMonitoring()
        {
            return View();
        }

        public ActionResult DisplacementDatasRealTimeMonitoring()
        {
            return View();
        }

        public ActionResult CableForceDatasRealTimeMonitoring()
        {
            return View();
        }

        public ActionResult HumidityDatasRealTimeMonitoring()
        {
            return View();
        }

        public ActionResult TemperatureDatasRealTimeMonitoring()
        {
            return View();
        }
    }
}