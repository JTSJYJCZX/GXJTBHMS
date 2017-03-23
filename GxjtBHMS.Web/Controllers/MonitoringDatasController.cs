using GxjtBHMS.Service;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.MonitoringDatas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    /// <summary>
    /// 监测数据查询控制器
    /// </summary>
    public class MonitoringDatasController : BaseController
    {
        IMonitoringTestTypeService _mtts;
        IMonitoringPointsNumberService _mpns;
        IMonitoringPointsPositionService _mpps;
        IFileConverter _fileConverter;
        public MonitoringDatasController
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
        public ActionResult DataQuery()
        {
            return View();
        }

        public ActionResult Query(MornitoringDataSearchBarBaseView conditions)
        {
            if (conditions.EndTime < conditions.StartTime)
            {
                return Content("<span style='color:red'>开始时间不能晚于结束时间</span>");
            }
            var req = new DatasQueryResultRequest
            {
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                PointsPositionId = conditions.MornitoringPointsPositionId
            };
            var monitoringDatasQueryService = MonitoringDatasEigenvalueQueryServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeId);
            var result = monitoringDatasQueryService.HasQueryResult(req);
            if (result)
            {
                return PartialView("DataQuerySearchContentPartial");
            }
            return Content("<span style='color:red'>无记录</span>");
        }
        //获取曲线图数据
        public ActionResult GetChartDatas(MornitoringDataSearchBarBaseView conditions)
        {
            var resp = new ChartDatasResponse();
            var req = new GetChartDatasRequest
            {
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                PointsPositionId = conditions.MornitoringPointsPositionId
            };
            var monitoringDatasQueryService = MonitoringDatasEigenvalueQueryServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeId);
            resp = monitoringDatasQueryService.GetChartDatasBy(req);
            return Json(resp.Datas, JsonRequestBehavior.AllowGet);
        }

        [ChildActionOnly]
        public ActionResult GetDataQuerySearchBar()
        {
            int firstTestTypeId;
            SaveMonitoringTestTypesSelectListItemsToViewData(out firstTestTypeId);
            int tmpMornitoringPointsPositionId;
            SaveMonitoringPointsPositionSelectListItemsToViewData(firstTestTypeId, out tmpMornitoringPointsPositionId);
            SaveMonitoringPointsNumberSelectListItemsToViewData(tmpMornitoringPointsPositionId);
            return PartialView("DataQuerySearchPartial");
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
        /// 原始数据下载，另存为EXCEL文档
        /// </summary>
        /// <returns></returns>
        public ActionResult OriginalValueDownloadSearchResult(MornitoringDataSearchBarBaseView conditions)
        {
            var req = new DatasQueryResultRequestBase
            {
                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsPositionId = conditions.MornitoringPointsPositionId
            };
            var monitoringDatasQueryService = MonitoringDatasOriginalValueDownloadServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeId);
            var resp = monitoringDatasQueryService.SaveAsFile(req);
            var guid = "";
            guid = Guid.NewGuid().ToString();
            CacheHelper.SetCache(guid, resp.Datas);
            return Json(guid, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 特征值下载，另存为EXCEL文档
        /// </summary>
        /// <returns></returns>
        public ActionResult EigenvalueDownloadSearchResult(MornitoringDataSearchBarBaseView conditions)
        {
            var req = new DatasQueryResultRequestBase
            {
                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsPositionId = conditions.MornitoringPointsPositionId
            };
            var monitoringDatasQueryService = MonitoringDatasEigenvalueQueryServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeId);
            var resp = monitoringDatasQueryService.SaveAsFile(req);
            var guid = Guid.NewGuid().ToString();
            CacheHelper.SetCache(guid, resp.Datas);
            return Json(guid, JsonRequestBehavior.AllowGet);
        }

        public void OriginCode(string guid, int pointsPositionId,string dataType)
        {
            object obj = CacheHelper.GetCache(guid);
            if (obj == null)
            {
                throw new ApplicationException("guid invalid");
            }
            var ms = _fileConverter.GetStream(obj);
            string preFileName = GetDownloadPreFileNameByTestTypeId(pointsPositionId,dataType);
            Response.AddHeader("Content-Disposition", string.Format("attachment; filename={0}.xls", preFileName));
            Response.BinaryWrite(ms.ToArray());
            ms.Close();
            ms.Dispose();
            CacheHelper.RemoveAllCache(guid);
        }

        string GetDownloadPreFileNameByTestTypeId(int pointsPositionId, string dataType)
        {
            return  _mpps.CreateDownloadFileMixedName(pointsPositionId,dataType) ;
        }
    }
}