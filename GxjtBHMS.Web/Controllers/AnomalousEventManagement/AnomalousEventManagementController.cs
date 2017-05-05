using System.Collections.Generic;
using System.Web.Mvc;
using GxjtBHMS.Web.Models;
using System;
using GxjtBHMS.Service.Interfaces;
using System.Linq;
using GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.ServiceFactory;
using GxjtBHMS.Web.ViewModels.AnomalousEventManagement;
using GxjtBHMS.Infrastructure.Configuration;

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


        public ActionResult AnomalousEventManagement(int currentPage = 1)
        {
            var req = new DatasQueryResultRequestBase() { CurrentPageIndex = currentPage };
            var testTypes = _mtts.GetAllTestType().Datas.Count();
            long resultCount = 0;
            for (int i = 1; i <= testTypes; i++)
            {
                var AnomalousEventQueryService = AnomalousEventManagementFactory.GetQueryServiceFrom(i);
                var result = AnomalousEventQueryService.GetAnomalousEventManagementDatasBy(req);
                if (result.Succeed)
                {
                    resultCount += result.TotalResultCount;
                }
            }
            var resp = new AnomalousEventManagementResponseViewModel();
            resp.TotalResultCount = resultCount;
            if (resp.TotalResultCount > 0)
            {
                resp.Succeed = true;
                ViewData["TotalPages"] = resp.TotalPages;
            }
            else
            {
                TempData[WebConstants.MessageColor] = StyleConstants.RedColor;
                TempData[WebConstants.Message] = "无记录！";
            }
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
            firstTestTypeId = 0;
            var resp = _mtts.GetAllTestType();
            if (resp.Datas.Any())
            {
                firstTestTypeId = Convert.ToInt32(resp.Datas.First().Id);
            }
            SaveSelectListItemCollectionToViewData(resp.Datas, WebConstants.MonitoringTestTypesKey, true);
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
            SaveSelectListItemCollectionToViewData(resp.Datas, WebConstants.MonitoringPointsPositionKey, true);
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

        public ActionResult GetAnomalousEvents(AnomalousEventsQueryConditionView condition)
        {
            var req = new AnomalousEventsQueryRequest()
            {
                CurrentPageIndex = condition.CurrentPageIndex,
                TestTypeId = condition.TestTypeId,
                PointsPositionId = condition.PointsPositionId,
                StartTime = condition.StartTime,
                EndTime = condition.EndTime
            };
            var models = new List<AnomalousEventManagementViewModel>();
            var sours=new List<AnomalousEventManagementViewModel>();
            long resultCount = 0;

            if (condition.TestTypeId == 0)
            {
                models = GetAllAnomalousDatas(req, sours, ref resultCount);
            }
            else
            {
                resultCount = GetAnomalousByTestTypeId(condition, req, models, resultCount);
            }
            var resp = new AnomalousEventManagementResponseViewModel();
            resp.Datas = models;
            resp.TotalResultCount = resultCount;
            if (resp.TotalResultCount > 0)
            {
                resp.Succeed = true;
                ViewData["TotalPages"] = resp.TotalPages;
                resp.CurrentPage = condition.CurrentPageIndex;
            }
            else
            {
                TempData[WebConstants.MessageColor] = StyleConstants.RedColor;
                TempData[WebConstants.Message] = "无记录！";
            }
            return PartialView("AnomalousEventManagementSearchAllContentPartial", resp);
        }

        private static long GetAnomalousByTestTypeId(AnomalousEventsQueryConditionView condition, AnomalousEventsQueryRequest req, List<AnomalousEventManagementViewModel> models, long resultCount)
        {
            var AnomalousEventQueryService = AnomalousEventManagementFactory.GetQueryServiceFrom(condition.TestTypeId);
            var result = AnomalousEventQueryService.GetAnomalousEventManagementDatasBy(req);
            if (result.Succeed)
            {
                SetDatasToViewModel(models, result);
                resultCount = result.TotalResultCount;
            }

            return resultCount;
        }

        static void SetDatasToViewModel(List<AnomalousEventManagementViewModel> models, dynamic result)
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
        }

        /// <summary>
        /// 获得8种类型的所有数据
        /// </summary>
        /// <param name="req"></param>
        /// <param name="sours"></param>
        /// <param name="resultCount"></param>
        /// <returns></returns>
        List<AnomalousEventManagementViewModel> GetAllAnomalousDatas(AnomalousEventsQueryRequest req, List<AnomalousEventManagementViewModel> sours, ref long resultCount)
        {
            List<AnomalousEventManagementViewModel> models;
            var testTypes = _mtts.GetAllTestType().Datas.Count();
            for (int i = 1; i <= testTypes; i++)
            {
                var AnomalousEventQueryService = AnomalousEventManagementFactory.GetQueryServiceFrom(i);
                var result = AnomalousEventQueryService.GetAllAnomalousEventManagementDatasBy(req);
                if (result.Succeed)
                {
                    SetDatasToViewModel(sours, result);
                    resultCount += result.TotalResultCount;
                }
            }
            //对所有数据重新分页！
            var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
            models = sours.OrderBy(m => m.Time).
                 Skip((req.CurrentPageIndex - 1) * numberOfResultsPrePage).
                 Take(numberOfResultsPrePage).
                 ToList();
            return models;
        }
    }
}