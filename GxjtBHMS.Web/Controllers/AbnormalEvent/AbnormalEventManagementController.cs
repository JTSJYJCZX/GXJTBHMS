using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ServiceFactory;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.SafetyPreWarning;
using GxjtBHMS.Web.ViewModels.SafetyPreWarning;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers.AbnormalEvent
{
    public class AbnormalEventManagementController : BaseController
    {
        public ActionResult AbnormalEventManagement()
        {
            return View();
        }

        //[ChildActionOnly]
        //public ActionResult AbnormalEventSearchBar()
        //{
        //    return PartialView("SearchPartialContent");
        //}
    } 
}