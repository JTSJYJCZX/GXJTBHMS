using GxjtBHMS.Service.AbnomalThresholdValueService;
using GxjtBHMS.Web.Models.Attributes;
using GxjtBHMS.Web.ViewModels.AbnormalThresholdValue;
using GxjtBHMS.Web.ViewModels.AbnormalThresholdValueSetting;
using System.Collections.Generic;
using System.Web.Mvc;
using GxjtBHMS.Service.Messaging.AbnomalThresholdValueSetting;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.Controllers.AbnormalThresholdValue
{

    public class AbnormalThresholdValueSettingController : Controller
    {
        // GET: Default
        public ActionResult AbnormalThresholdValueSetting()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult GetAbnormalThresholdValueList()
        {
            var abnormalthresholdValueSettingService = new AbnormalThresholdValueSettingService();
            var resp = abnormalthresholdValueSettingService.GetAbnormalThresholdValueList();
            var models = new List<AbnormalThresholdValueView>();
            var resultView = new AbnormalThresholdValueSettingView();
            if (resp.Succeed)
            {

                foreach (var item in resp.AbnormalThresholdValue)
                {
                    var resultItem = new AbnormalThresholdValueView();
                    resultItem.TypeId = item.Id;
                    resultItem.TypeName = item.TypeName;
                    resultItem.MaxLevelThresholdValue = item.MaxLevelThresholdValue;
                    resultItem.MinLevelThresholdValue = item.MinLevelThresholdValue;
                    models.Add(resultItem);
                }
                resultView.AbnormalThresholdValues = models;
                return PartialView("AbnormalThresholdValueListPartial", resultView);

            }
            else
            {
                TempData[WebConstants.MessageColor] = StyleConstants.RedColor;
                TempData[WebConstants.Message] = resp.Message;
                return null;
            }
        }

        /// <summary>
        /// 修改阈值后保存阈值
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        [MyValidateAntiForgeryToken]
        public ActionResult AbnormalSaveThresholdValue(AbnormalThresholdValueView model)
        {
            var color = string.Empty;
            var message = string.Empty;
            if (ModelState.IsValid)
            {
                var req = new AbnormalThresholdValueSettingRequest
                {
                    TypeId = model.TypeId,
                    MaxLevelThresholdValue = model.AbnormalThresholdValues[0],
                    MinLevelThresholdValue = model.AbnormalThresholdValues[1]
                };
                var abnomalthresholdValueSettingService = new AbnormalThresholdValueSettingService();
                var resp = abnomalthresholdValueSettingService.ModifyAbnormalThresholdValue(req);
                message = resp.Message;
                color = resp.Succeed ? StyleConstants.GreenColor : StyleConstants.RedColor;
            }
            else
            {
                message = "阈值设置错误！";
                color = StyleConstants.RedColor;
            }
            return Json(new { color, message }, JsonRequestBehavior.AllowGet);
        }

    }
}