using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ServiceFactory;
using NPOI.SS.Formula.Functions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers.SafetyPreWarning
{
    public class SafetyPreWarningController : Controller
    {
        // GET: SafetyPreWarning
        public ActionResult SafetyPreWarning()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult GetSafetyWarningSearchContent()
        {

            return PartialView("GetSafetyWarningSearchContentPartial");
        }

        public ActionResult GetSafetyWarningDetail(int mornitoringTestTypeId=3)
        {
            var resp=new SafetyWarningDetailResponse();
            DateTime now = DateTime.Now;
            var req = new GetSafetyWarningDetailRequest
            {
                StartTime = new DateTime(now.Year, now.Month, 1),
                EndTime = now
            };
             var SafetyWarningDetailQueryService = SafetyWarningDetailFactory.GetSafetyWarningDetailServiceFrom(mornitoringTestTypeId);
            resp = SafetyWarningDetailQueryService.GetSafetyPreWarningDetailBy(req);
            return Json(resp.Datas,JsonRequestBehavior.AllowGet);
        }
    }
}