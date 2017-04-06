using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Web.ViewModels.ThresholdValueSetting;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Linq;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.Messaging;
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
        public ThresholdValueSettingController(IMonitoringTestTypeService mtts,
            IMonitoringPointsNumberService mpns,
            IMonitoringPointsPositionService mpps)
        {
            _mtts = mtts;
            _mpns = mpns;
            _mpps = mpps;
        }

        public ActionResult ThresholdValueSetting()
        {
            return View();
        }

        /// <summary>
        /// 通过下拉菜单条件查询阈值列表
        /// </summary>
        /// <param name="conditions"></param>
        /// <returns></returns>
        public ActionResult GetThresholdValueSettingListByPullDownSearchBar(ThresholdValueSearchBarBaseView conditions)
        {

            var req = new GetThresholdValueByPointsPositionSearchRequest
            {
               PointsPositionId=conditions.MornitoringPointsPositionId
            };
            var thresholdValueSettingService = ThresholdValueSettingServiceFactory.GetThresholdValueServiceFrom(conditions.MornitoringTestTypeId);
            var resp = thresholdValueSettingService.GetThresholdValueListByPointsPosition(req);
            var models = new List<ThresholdValueView>();
            var resultView = new ThresholdValueSettingView();
            if (resp.Succeed)
            {
                if (resp.IsContainNegative)
                {
                    foreach (var item in resp.ThresholdValueContainNegative)
                    {
                        var resultItem = new ThresholdValueView();
                        resultItem.TestTypeId = conditions.MornitoringTestTypeId;
                        resultItem.PointsNumber = item.PointsNumberName;
                        resultItem.PointsNumberId = item.PointsNumberId;
                        resultItem.PositiveFirstLevelThresholdValue = item.PositiveFirstLevelThresholdValue;
                        resultItem.PositiveSecondLevelThresholdValue = item.PositiveSecondLevelThresholdValue;
                        resultItem.NegativeFirstLevelThresholdValue = item.NegativeFirstLevelThresholdValue;
                        resultItem.NegativeSecondLevelThresholdValue = item.NegativeSecondLevelThresholdValue;
                        resultItem.IsContainNegative = true;
                        models.Add(resultItem);
                    }
                    resultView.ThresholdValues = models;
                }
                else
                {
                    foreach (var item in resp.ThresholdValuesWithoutNegative)
                    {
                        var resultItem = new ThresholdValueView();
                        resultItem.TestTypeId = conditions.MornitoringTestTypeId;
                        resultItem.PointsNumber = item.PointsNumberName;
                        resultItem.PointsNumberId = item.PointsNumberId;
                        resultItem.PositiveFirstLevelThresholdValue = item.PositiveFirstLevelThresholdValue;
                        resultItem.PositiveSecondLevelThresholdValue = item.PositiveSecondLevelThresholdValue;
                        resultItem.IsContainNegative = false;
                        models.Add(resultItem);
                    }
                    resultView.ThresholdValues = models;
                }
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

        /// <summary>
        /// 通过查询条件获得阈值搜索条件
        /// </summary>
        /// <param name="conditions"></param>
        /// <returns></returns>
        public IEnumerable<ThresholdValueQueryConditionModel> GetThresholdValueSearchConditionByConditonPointsNumber(QueryPointsNumberConditonView conditions)
        {
            var req = new PointsNumberSearchRequest
            {//自动去除前导空格
                PointNumber = conditions.ContainsPointsNumber.Trim()
            };
            var thresholdValueSettingService = new GetThresholdValueSettingListBySearchBarService();
            return thresholdValueSettingService.GetPointsPositionsByContainPointsNumber(req.PointNumber);
        }

       /// <summary>
       /// 通过搜索栏查询阈值列表
       /// </summary>
       /// <param name="conditions"></param>
       /// <returns></returns>
        public ActionResult GetThresholdValueSettingList(QueryPointsNumberConditonView conditions)
        {
            var models = new List<ThresholdValueView>();
            var resultView = new ThresholdValueSettingView();
            var  resultCondition=  GetThresholdValueSearchConditionByConditonPointsNumber(conditions);
            foreach (var item in resultCondition)
            {
                var req = new GetThresholdValueByPointsPositionSearchRequest
                {
                    PointsPositionId = item.PointsPositionId,
                    PointsNumber=item.PointsName

                };
                var thresholdValueSettingService = ThresholdValueSettingServiceFactory.GetThresholdValueServiceFrom(item.TestTypeId);

                var resultByPointNumber = thresholdValueSettingService.GetThresholdValueListByPointsNumber(req);

                if (resultByPointNumber.IsContainNegative)
                {                  
                        var resultItem = new ThresholdValueView();
                        resultItem.TestTypeId = item.TestTypeId;
                        resultItem.PointsNumber = resultByPointNumber.PointsNumberName;
                        resultItem.PointsNumberId = resultByPointNumber.PointsNumberId;
                        resultItem.PositiveFirstLevelThresholdValue = resultByPointNumber.PositiveFirstLevelThresholdValue;
                        resultItem.PositiveSecondLevelThresholdValue = resultByPointNumber.PositiveSecondLevelThresholdValue;
                        resultItem.NegativeFirstLevelThresholdValue = resultByPointNumber.NegativeFirstLevelThresholdValue;
                        resultItem.NegativeSecondLevelThresholdValue = resultByPointNumber.NegativeSecondLevelThresholdValue;
                    resultItem.IsContainNegative = true;
                        models.Add(resultItem);
                    }
                else
                {
                    var resultItem = new ThresholdValueView();
                    resultItem.TestTypeId = item.TestTypeId;
                    resultItem.PointsNumber = resultByPointNumber.PointsNumberName;
                    resultItem.PointsNumberId = resultByPointNumber.PointsNumberId;
                    resultItem.PositiveFirstLevelThresholdValue = resultByPointNumber.PositiveFirstLevelThresholdValue;
                    resultItem.PositiveSecondLevelThresholdValue = resultByPointNumber.PositiveSecondLevelThresholdValue;
                    resultItem.IsContainNegative = false;
                    models.Add(resultItem);
                }
                resultView.ThresholdValues = models;
            }

            return PartialView("ThresholdValueSettingListPartial", resultView);
        }

        [ChildActionOnly]
        public ActionResult GetThresholdValueSearchBar()
        {
            return PartialView("ThresholdValueSearchPartial");
        }

        /// <summary>
        /// 修改阈值后保存阈值
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        [MyValidateAntiForgeryToken]
        public ActionResult SaveThresholdValue(ThresholdValueView model)
        {
            var color = string.Empty;
            var message = string.Empty;
            if (ModelState.IsValid)
            {
                var req = new ThresholdValueSettingRequest
                {
                    PointsNumber = model.PointsNumber,
                    PointsNumberId = model.PointsNumberId
                };
                SaveThresholdValuesFromViewToRequest(req, model);
                var thresholdValueSettingService = ThresholdValueSettingServiceFactory.GetThresholdValueServiceFrom(model.TestTypeId);
                var resp = thresholdValueSettingService.ModifyThresholdValue(req);
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

        void SaveThresholdValuesFromViewToRequest(ThresholdValueSettingRequest req, ThresholdValueView model)
        {
                var tg = ThresholdValuesConvert.ConvertForm(model.ThresholdValues);
                req.PositiveFirstLevelThresholdValue = tg.PositiveStandardValueGroup.FirstLevelThresholdValue;
                req.PositiveSecondLevelThresholdValue = tg.PositiveStandardValueGroup.SecondLevelThresholdValue;
                req.NegativeFirstLevelThresholdValue = tg.NegativeStandardValueGroup.FirstLevelThresholdValue;
                req.NegativeSecondLevelThresholdValue = tg.NegativeStandardValueGroup.SecondLevelThresholdValue;
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

    }
}