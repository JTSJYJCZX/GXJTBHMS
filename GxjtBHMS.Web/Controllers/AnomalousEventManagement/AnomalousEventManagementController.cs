using GxjtBHMS.Service.AbnomalThresholdValueService;
using GxjtBHMS.Web.Models.Attributes;
using GxjtBHMS.Web.ViewModels.AbnormalThresholdValue;
using GxjtBHMS.Web.ViewModels.AbnormalThresholdValueSetting;
using System.Collections.Generic;
using System.Web.Mvc;
using GxjtBHMS.Service.Messaging.AbnomalThresholdValueSetting;
using GxjtBHMS.Web.Models;
using System;
using GxjtBHMS.Service.Interfaces;
using System.Linq;
using GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas;
using GxjtBHMS.Web.ViewModels.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.ServiceFactory;
using GxjtBHMS.Web.ViewModels.AnomalousEventManagement;

namespace GxjtBHMS.Web.Controllers.AnomalousEventManagement
{

    public class AnomalousEventManagementController : BaseController
    {
        IMonitoringTestTypeService _mtts;
        readonly IMonitoringPointsPositionService _mpps;
        public AnomalousEventManagementController
           (IMonitoringTestTypeService mtts,
           IMonitoringPointsPositionService mpps
           )
        {
            _mtts = mtts;
            _mpps = mpps;
        }


        public ActionResult AnomalousEventManagement()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult GetDataQuerySearchBar()
        {
            int firstTestTypeId;
            SaveMonitoringTestTypesSelectListItemsToViewData(out firstTestTypeId);
            int tmpMornitoringPointsPositionId;
            SaveMonitoringPointsPositionSelectListItemsToViewData(firstTestTypeId, out tmpMornitoringPointsPositionId);
            return PartialView("AnomalousEventDataQuerySearchPartial");
        }
        /// <summary>
        /// 获得测试类型下拉列表
        /// </summary>
        void SaveMonitoringTestTypesSelectListItemsToViewData(out int firstTestTypeId)
        {
            firstTestTypeId = 1;
            var resp = _mtts.GetAllTestType();
            if (resp.Datas.Any())
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
            if (resp.Datas.Any())
            {
                mornitoringPointsPositionId = Convert.ToInt32(resp.Datas.First().Id);
            }
            SaveSelectListItemCollectionToViewData(resp.Datas, WebConstants.MonitoringPointsPositionKey, false);
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

        public ActionResult GetAllAnomalousEvents(int currentPage=1)
        {
            var req = new DatasQueryResultRequestBase() {CurrentPageIndex=currentPage };
            var testTypes = _mtts.GetAllTestType().Datas.Count();
            var models = new List<AnomalousEventManagementViewModel>();
            long resultCount = 0;
            for (int i = 1; i <= testTypes; i++)
            {
                var AnomalousEventQueryService = AnomalousEventManagementFactory.GetQueryServiceFrom(i);
                var result = AnomalousEventQueryService.GetAnomalousEventManagementDatasBy(req);
                if (result.Succeed)
                {
                    foreach (var item in result.Datas)
                    {
                        var model = new AnomalousEventManagementViewModel()
                        {
                            Time = item.Time,
                            TestType = item.TestType,
                            PointsPosition = item.PointsPosition,
                            PointsNumber = item.PointsNumber,
                            AnomalousEventReason = item.AnomalousEventReason
                        };
                        models.Add(model);
                    }
                    resultCount += result.TotalResultCount;
                }
            }
            var resp = new AnomalousEventManagementResponseViewModel();
            resp.Datas = models;
            resp.TotalResultCount = resultCount;
            if (resp.TotalResultCount > 0)
            {
                resp.Succeed = true;
                ViewData["TotalPages"] = resp.TotalPages;
                resp.CurrentPage = currentPage;
            }
            else
            {
                TempData[WebConstants.MessageColor] = StyleConstants.RedColor;
                TempData[WebConstants.Message] = "无记录！";
            }
            return PartialView("AnomalousEventManagementSearchAllContentPartial",resp);
        }


    }
}