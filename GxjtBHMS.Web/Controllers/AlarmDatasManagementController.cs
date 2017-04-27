using GxjtBHMS.Service;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.AlarmDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.AlarmDatas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    public class AlarmDatasManagementController : BaseController
    {
        IMonitoringTestTypeService _mtts;
        IMonitoringPointsNumberService _mpns;
        readonly IMonitoringPointsPositionService _mpps;
        IFileConverter _fileConverter;
        public AlarmDatasManagementController
            (IMonitoringTestTypeService mtts,
            IMonitoringPointsNumberService mpns,
            IMonitoringPointsPositionService mpps,
           IFileConverter fileConverter
            )
        {
            _mtts = mtts;
            _mpns = mpns;
            _mpps = mpps;
            _fileConverter = fileConverter;
        }
        /// <summary>
        /// 视图页
        /// </summary>
        /// <returns></returns>
        public ActionResult AlarmDatasManagementQuery()
        {
            return View();
        }
        /// <summary>
        /// 报警数据查询
        /// </summary>
        /// <param name="conditions">查询条件</param>
        /// <returns>数据查询内容分布视图</returns>
        public ActionResult AlarmDatasQuery(AlarmDatasSearchBarView conditions)
        {
            if (conditions.EndTime < conditions.StartTime)
            {
                return Content("<span style='color:red'>开始时间不能晚于结束时间</span>");
            }
            var req = new DatasQueryResultRequest
            {
                CurrentPageIndex = conditions.CurrentPageIndex,
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                PointsPositionId = conditions.MornitoringPointsPositionId
            };
            var monitoringDatasQueryService = AlarmDatasManagementServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeId);
            var result = monitoringDatasQueryService.GetTotalPagesBy(req);
            if (result.TotalPages > 0)
            {
                ViewData["TotalPages"] = result.TotalPages;
                return PartialView("DataQuerySearchContentPartial");
            }
            return Content("<span style='color:red'>无记录</span>");
        }
        


        //获取报警数据
        public ActionResult GetAlarmDatas(AlarmDatasSearchBarView conditions)
        {
            var resp = new AlarmDatasResponse();
            var req = new GetAlarmDatasRequest
            {
                CurrentPageIndex = conditions.CurrentPageIndex,
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                PointsPositionId = conditions.MornitoringPointsPositionId
            };
            var monitoringDatasQueryService = AlarmDatasManagementServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeId);
            resp = monitoringDatasQueryService.GetAlarmDatasBy(req);
            var resultView = new AlarmDatasSeachResultView();
            resultView.Datas = resp.Datas;
            resultView.PaginatorModel = new ViewModels.PaginatorModel { TotalPages = resp.TotalPages, CurrentPageIndex = conditions.CurrentPageIndex };

            return PartialView("AlarmDatasQueryListViewPartial", resultView);
        }

        [ChildActionOnly]
        public ActionResult GetDataQuerySearchBar()
        {
            int firstTestTypeId;
            SaveMonitoringTestTypesSelectListItemsToViewData(out firstTestTypeId);
            int tmpMornitoringPointsPositionId;
            SaveMonitoringPointsPositionSelectListItemsToViewData(firstTestTypeId, out tmpMornitoringPointsPositionId);
            SaveMonitoringPointsNumberSelectListItemsToViewData(tmpMornitoringPointsPositionId);
            return PartialView("AlarmDataQuerySearchPartial");
        }
        /// <summary>
        /// 获得测试类型下拉列表
        /// </summary>
        void SaveMonitoringTestTypesSelectListItemsToViewData(out int firstTestTypeId)
        {
            firstTestTypeId = 1;
            var resp = _mtts.GetAllTestType().Datas.Where(m => m.Name == "索力" || m.Name == "位移" || m.Name == "温度" || m.Name == "湿度");
            if (resp.Any())
            {
                firstTestTypeId = Convert.ToInt32(resp.First().Id);
            }
            SaveSelectListItemCollectionToViewData(resp, WebConstants.MonitoringTestTypesKey, false);
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
        /// <summary>
        /// 获得测点编号下拉列表
        /// </summary>
        void SaveMonitoringPointsNumberSelectListItemsToViewData(int mornitoringPointsPositionId = 0)
        {
            var resp = _mpns.GetMonitoringPointsNumberByPointsPositionId(mornitoringPointsPositionId);
            SaveSelectListItemCollectionToViewData(resp.Datas, WebConstants.MonitoringPointsNumberKey, false);
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

        /// <summary>
        /// 报警数据下载，另存为EXCEL文档
        /// </summary>
        /// <returns></returns>
        public ActionResult AlarmDatasDownloadSearchResult(AlarmDatasSearchBarView conditions)
        {
            var req = new DatasQueryResultRequestBase
            {
                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsPositionId = conditions.MornitoringPointsPositionId
            };
            var alarmDatasQueryService = AlarmDatasManagementServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeId);
            var resp = alarmDatasQueryService.SaveAs(req);
            var guid = "";
            guid = Guid.NewGuid().ToString();
            CacheHelper.SetCache(guid, resp.Datas);
            return Json(guid, JsonRequestBehavior.AllowGet);
        }

        public void OriginCode(string guid, int pointsPositionId, string dataType)
        {
            object obj = CacheHelper.GetCache(guid);
            if (obj == null)
            {
                throw new ApplicationException("guid invalid");
            }
            var ms = _fileConverter.GetStream(obj);
            string preFileName = GetDownloadPreFileNameByTestTypeId(pointsPositionId, dataType);
            Response.AddHeader("Content-Disposition", string.Format("attachment; filename={0}.xls", preFileName));
            Response.BinaryWrite(ms.ToArray());
            ms.Close();
            ms.Dispose();
            CacheHelper.RemoveAllCache(guid);
        }

        string GetDownloadPreFileNameByTestTypeId(int pointsPositionId, string dataType)
        {
            return _mpps.CreateDownloadFileMixedName(pointsPositionId, dataType);
        }

    }
}