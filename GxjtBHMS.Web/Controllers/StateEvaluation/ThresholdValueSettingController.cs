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
using System;
using GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas;
using GxjtBHMS.Service;

namespace GxjtBHMS.Web.Controllers.StateEvaluation
{
    public class ThresholdValueSettingController : BaseController
    {
        IMonitoringTestTypeService _mtts;
        IMonitoringPointsNumberService _mpns;
        IMonitoringPointsPositionService _mpps;
        readonly IThresholdValueSettingService _thresholdValueSettingService;
        public ThresholdValueSettingController(IThresholdValueSettingService thresholdValueSettingService, IMonitoringTestTypeService mtts,
            IMonitoringPointsNumberService mpns,
            IMonitoringPointsPositionService mpps)
        {
            _thresholdValueSettingService = thresholdValueSettingService;
            _mtts = mtts;
            _mpns = mpns;
            _mpps = mpps;
        }

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

        public ActionResult GetThresholdValueSettingListByPullDownSearchBar(ThresholdValueSearchBarBaseView conditions)
        {

            var req = new GetThresholdValueByPointsPositionSearchRequest
            {
               PointsPositionId=conditions.MornitoringPointsPositionId
            };
            var thresholdValueSettingService = ThresholdValueSettingServiceFactory.GetThresholdValueServiceFrom(conditions.MornitoringTestTypeId);
            var resp = thresholdValueSettingService.GetThresholdValueListByPointsPosition(req);
            IEnumerable<StrainThresholdValueView> models = new List<StrainThresholdValueView>();
            var resultView = new ThresholdValueSettingView();
            if (resp.Succeed)
            {
                resultView.StrainThresholdValues = resp.ConcreteStrainThresholdValues.Select(m => new StrainThresholdValueView
                {
                    PointsNumber = m.PointsNumber.Name,
                    PointsNumberId = m.PointsNumberId,
                    PositiveFirstLevelThresholdValue = m.PositiveFirstLevelThresholdValue,
                    PositiveSecondLevelThresholdValue = m.PositiveSecondLevelThresholdValue,
                    NegativeFirstLevelThresholdValue = m.NegativeFirstLevelThresholdValue,
                    NegativeSecondLevelThresholdValue = m.NegativeSecondLevelThresholdValue,

                });
            }
            else
            {
                return Json(new { color = StyleConstants.RedColor, message = resp.Message }, JsonRequestBehavior.AllowGet);
            }
            return PartialView("ThresholdValueSettingListPartial",resultView);
        }




        [ChildActionOnly]
        public ActionResult GetThresholdValuePullDownSearchBar()
        {
            int firstTestTypeId;
            SaveMonitoringTestTypesSelectListItemsToViewData(out firstTestTypeId);
            int tmpMornitoringPointsPositionId;
            SaveMonitoringPointsPositionSelectListItemsToViewData(firstTestTypeId, out tmpMornitoringPointsPositionId);
            return PartialView("ThresholdValuePullDownSearchPartial");
        }

        /// <summary>
        /// 获得测试类型下拉列表
        /// </summary>
        void SaveMonitoringTestTypesSelectListItemsToViewData(out int firstTestTypeId)
        {
            firstTestTypeId = 1;
            var resp = _mtts.GetAllTestType();
            if (resp.Datas.Count() > 0)
            {
                firstTestTypeId = Convert.ToInt32(resp.Datas.First().Id);
            }
            SaveSelectListItemCollectionToViewData(resp.Datas, WebConstants.MonitoringTestTypesKey, false);
        }
        /// <summary>
        /// 获得测点位置下拉列表
        /// </summary>
        void SaveMonitoringPointsPositionSelectListItemsToViewData(int mornitoringTestTypeId, out int mornitoringPointsPositionId)
        {
            var resp = _mpps.GetMonitoringPointsPositionsByTestTypeId(mornitoringTestTypeId);
            mornitoringPointsPositionId = 0;
            if (resp.Datas.Count() > 0)
            {
                mornitoringPointsPositionId = Convert.ToInt32(resp.Datas.First().Id);
            }
            SaveSelectListItemCollectionToViewData(resp.Datas, WebConstants.MonitoringPointsPositionKey, false);
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
                resultView.StrainThresholdValues = resp.ConcreteStrainThresholdValues.Select(m => new StrainThresholdValueView
                {
                    PointsNumber = m.PointsNumber.Name,
                    PointsNumberId = m.PointsNumberId,
                    PositiveFirstLevelThresholdValue = m.PositiveFirstLevelThresholdValue,
                    PositiveSecondLevelThresholdValue = m.PositiveSecondLevelThresholdValue,           
                    NegativeFirstLevelThresholdValue = m.NegativeFirstLevelThresholdValue,
                    NegativeSecondLevelThresholdValue = m.NegativeSecondLevelThresholdValue,
     
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
                req.PositiveFirstLevelThresholdValue = tg.PositiveStandardValueGroup.FirstLevelThresholdValue;
                req.PositiveSecondLevelThresholdValue = tg.PositiveStandardValueGroup.SecondLevelThresholdValue;
                req.NegativeFirstLevelThresholdValue = tg.NegativeStandardValueGroup.FirstLevelThresholdValue;
                req.NegativeSecondLevelThresholdValue = tg.NegativeStandardValueGroup.SecondLevelThresholdValue;
        }

        public ActionResult UniformSettingThresholdValue()
        {            
            return PartialView("UniformSettingStrainThresholdValuePartial");
        }

        public ActionResult GetMonitoringPointsPositionsByTestTypeId(int testTypeId = 0)
        {
            IList<SelectListItem> selectListItemCollection = new List<SelectListItem>();

            var resp = _mpps.GetMonitoringPointsPositionsByTestTypeId(testTypeId);

            if (resp.Succeed)
            {
                selectListItemCollection = resp
                    .Datas
                    .ConvertToSelectListItemCollection();
            }

            return Json(selectListItemCollection, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetMonitoringPointsNumbersByPointsPositions(int pointsPositions = 0)
        {
            IList<SelectListItem> selectListItemCollection = new List<SelectListItem>();

            var resp = _mpns.GetMonitoringPointsNumberByPointsPositionId(pointsPositions);

            if (resp.Succeed)
            {
                selectListItemCollection = resp
                    .Datas
                    .ConvertToSelectListItemCollection();
            }

            return Json(selectListItemCollection, JsonRequestBehavior.AllowGet);
        }
    }
}