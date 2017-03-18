using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Web.ViewModels.ThresholdValueSetting;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Linq;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Web.ViewModels;
using GxjtBHMS.Web.Models.Attributes;

namespace GxjtBHMS.Web.Controllers.StateEvaluation
{
    public class ThresholdValueSettingController : Controller
    {
        public ThresholdValueSettingController(IThresholdValueSettingService thresholdValueSettingService)
        {
            _thresholdValueSettingService = thresholdValueSettingService;
        }
        readonly IThresholdValueSettingService _thresholdValueSettingService;


        public ActionResult ThresholdValueSetting()
        {
            var resp = _thresholdValueSettingService.GetPaginatorDatas(new PointsNumberSearchRequest());

            if (resp.Succeed)
            {
                ViewData["TotalPages"] = resp.TotalPages;
            }
            else
            {
                TempData[WebConstants.MessageColor] = StyleConstants.RedColor;
                TempData[WebConstants.MessageKey] = resp.Message;
            }
            return View();
        }

        public ActionResult GetThresholdValueSettingList(QueryPointsNumberConditonView conditions)
        {
            var req = new PointsNumberSearchRequest
            {
                PointNumber = conditions.ContainsPointsNumber,
                CurrentPageIndex = conditions.CurrentPageIndex
            };
            var resp = _thresholdValueSettingService.GetThresholdValueBy(req);
            IEnumerable<StrainThresholdValueView> models = new List<StrainThresholdValueView>();
            var resultView = new ThresholdValueSettingView();
            if (resp.Succeed)
            {
                resultView.StrainThresholdValues = resp.StrainThresholdValues.Select(m => new StrainThresholdValueView
                {
                    PointsNumber = m.PointsNumber.Name,
                    PointsNumberId = m.PointsNumberId,
                    PositiveStandardValue = m.PositiveStandardValue,
                    PositiveFirstLevelThresholdValue = m.PositiveFirstLevelThresholdValue,
                    PositiveSecondLevelThresholdValue = m.PositiveSecondLevelThresholdValue,
                    PositiveThirdLevelThresholdValue = m.PositiveThirdLevelThresholdValue,
                    NegativeStandardValue = m.NegativeStandardValue,
                    NegativeFirstLevelThresholdValue = m.NegativeFirstLevelThresholdValue,
                    NegativeSecondLevelThresholdValue = m.NegativeSecondLevelThresholdValue,
                    NegativeThirdLevelThresholdValue = m.NegativeThirdLevelThresholdValue
                });
                resultView.PaginatorModel = new PaginatorModel { TotalPages = resp.TotalPages, CurrentPageIndex = conditions.CurrentPageIndex };
            }
            else
            {
                return Json(new { color = StyleConstants.RedColor, message = resp.Message }, JsonRequestBehavior.AllowGet);
            }
            return PartialView("ThresholdValueSettingListPartial", resultView);
        }

        [ChildActionOnly]
        public ActionResult GetThresholdValueSearchBar(QueryPointsNumberConditonView conditions)
        {
            return PartialView("ThresholdValueSearchPartial", conditions);
        }

        [HttpPost]
        [MyValidateAntiForgeryToken]
        public ActionResult SaveThresholdValue(StrainThresholdValueView model)
        {
            var color = string.Empty;
            var message = string.Empty;
            if (ModelState.IsValid)
            {
                var req = new StrainThresholdValueSettingRequest
                {
                    PointsNumber = model.PointsNumber,
                    PointsNumberId = model.PointsNumberId
                };
                SaveThresholdValuesFromViewToRequest(req,model);
                var resp = _thresholdValueSettingService.ModifyStrainThresholdValue(req);
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

        void SaveThresholdValuesFromViewToRequest(StrainThresholdValueSettingRequest req, StrainThresholdValueView model)
        {
                var tg = ThresholdValuesConvert.ConvertForm(model.ThresholdValues);
                req.PositiveStandardValue = tg.PositiveStandardValueGroup.StandardValue;
                req.PositiveFirstLevelThresholdValue = tg.PositiveStandardValueGroup.FirstLevelThresholdValue;
                req.PositiveSecondLevelThresholdValue = tg.PositiveStandardValueGroup.SecondLevelThresholdValue;
                req.PositiveThirdLevelThresholdValue = tg.PositiveStandardValueGroup.ThirdLevelThresholdValue;
                req.NegativeStandardValue = tg.NegativeStandardValueGroup.StandardValue;
                req.NegativeFirstLevelThresholdValue = tg.NegativeStandardValueGroup.FirstLevelThresholdValue;
                req.NegativeSecondLevelThresholdValue = tg.NegativeStandardValueGroup.SecondLevelThresholdValue;
                req.NegativeThirdLevelThresholdValue = tg.NegativeStandardValueGroup.ThirdLevelThresholdValue;
        }

        public ActionResult UniformSettingThresholdValue()
        {            
            return PartialView("UniformSettingStrainThresholdValuePartial");
        }
    }
}