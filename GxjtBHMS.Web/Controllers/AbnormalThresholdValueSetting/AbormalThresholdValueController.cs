using GxjtBHMS.Service.AbnomalThresholdValueService;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.AbormalThresholdValue;
using GxjtBHMS.Web.ViewModels.AbormalThresholdValueSetting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers.AbnormalThresholdValue
{
    public class AbormalThresholdValueController : Controller
    {
        // GET: Default
        public ActionResult AbormalThresholdValueSetting()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult GetAbnomalThresholdValueList()
        {
            var abnomalthresholdValueSettingService = new AbnomalThresholdValueSettingService();
            var resp = abnomalthresholdValueSettingService.GetAbnomalThresholdValueList();
            var models = new List<AbormalThresholdValueView>();
            var resultView = new AbormalThresholdValueSettingView();
            //if (resp.Succeed)
            //{
                
                    foreach (var item in resp.AbnomalThresholdValue)
                    {
                        var resultItem = new AbormalThresholdValueView();
                        resultItem.TypeId = item.Id;
                        resultItem.TypeName = item.TypeName;
                        resultItem.MaxLevelThresholdValue = item.MaxLevelThresholdValue;
                        resultItem.MinLevelThresholdValue = item.MinLevelThresholdValue;
                        models.Add(resultItem);
                    }
                    resultView.AbormalThresholdValues = models;
            //}
            //else
            //{
            //    return Json(new { color = StyleConstants.RedColor, message = resp.Message }, JsonRequestBehavior.AllowGet);
            //}

            return PartialView("AbnomalThresholdValueListPartial",resultView);
        }

    }
}