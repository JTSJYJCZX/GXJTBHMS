using System.Collections.Generic;
using System.Web.Mvc;
using GxjtBHMS.Web.Models;
using System;
using GxjtBHMS.Service.Interfaces;
using System.Linq;
using GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Web.ViewModels.AnomalousEventManagement;
using GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces;

namespace GxjtBHMS.Web.Controllers.AnomalousEventManagement
{

    public class AnomalousEventManagementController : BaseController
    {
        IMonitoringTestTypeService _mtts;
        readonly IMonitoringPointsPositionService _mpps;
        IAnomalousEventManagementQueryService _anomalousEventManagementService;
        IFileConverter _fileConverter;
        public AnomalousEventManagementController
           (IMonitoringTestTypeService mtts,
           IMonitoringPointsPositionService mpps,
           IAnomalousEventManagementQueryService anomalousEventManagementService,
            IFileConverter fileConverter
           )
        {
            _mtts = mtts;
            _mpps = mpps;
            _anomalousEventManagementService = anomalousEventManagementService;
            _fileConverter = fileConverter;
        }


        public ActionResult AnomalousEventManagement(int currentPage = 1)
        {
            var req = new DatasQueryResultRequestBase() { CurrentPageIndex = currentPage };
            var testTypes = _mtts.GetAllTestType().Datas.Count();
            long resultCount = 0;
            for (int i = 1; i <= testTypes; i++)
            {
                var result = _anomalousEventManagementService.GetAnomalousEventManagementDatasBy(req);
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
                var result = _anomalousEventManagementService.GetAnomalousEventManagementDatasBy(req);
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
                    resultCount = result.TotalResultCount;
                }

            var resp = new AnomalousEventManagementResponseViewModel();
            resp.Datas = models;
            resp.TotalResultCount = resultCount;
            string partialView = null;
            if (resp.TotalResultCount > 0)
            {
                resp.Succeed = true;
                ViewData["TotalPages"] = resp.TotalPages;
                resp.CurrentPage = condition.CurrentPageIndex;
                partialView = "AnomalousEventManagementContentPartial";
            }
            else
            {
                //resp.Message = result.Message;
                TempData[WebConstants.MessageColor] = StyleConstants.RedColor;
                TempData[WebConstants.Message] = "无记录！";
                partialView = "NoAnomalousEventManagementContentPartial";
            }
            return PartialView(partialView, resp);
        }

        /// <summary>
        /// 异常事件下载，另存为EXCEL文档
        /// </summary>
        /// <returns></returns>
        public ActionResult AnomalousEventsDownloadSearchResult(AnomalousEventsQueryConditionView condition)
        {
            var req = new AnomalousEventsQueryRequest()
            {
                CurrentPageIndex = condition.CurrentPageIndex,
                TestTypeId = condition.TestTypeId,
                PointsPositionId = condition.PointsPositionId,
                StartTime = condition.StartTime,
                EndTime = condition.EndTime
            };
            var resp = _anomalousEventManagementService.SaveAs(req);
            var guid = Guid.NewGuid().ToString();
            CacheHelper.SetCache(guid, resp.Datas);
            return Json(guid, JsonRequestBehavior.AllowGet);
        }

        public void OriginCode(string guid)
        {
            object obj = CacheHelper.GetCache(guid);
            if (obj == null)
            {
                throw new ApplicationException("guid invalid");
            }
            var ms = _fileConverter.GetStream(obj);
            string preFileName = "异常事件数据表";
            Response.AddHeader("Content-Disposition", string.Format("attachment; filename={0}.xls", preFileName));
            Response.BinaryWrite(ms.ToArray());
            ms.Close();
            ms.Dispose();
            CacheHelper.RemoveAllCache(guid);
        }

    }
}