using GxjtBHMS.Service;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.MonitoringDatasComparing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    public class MonitoringDatasComparingQueryController : BaseController
    {
        IMonitoringTestTypeService _mtts;
        IMonitoringPointsNumberService _mpns;
        IMonitoringPointsPositionService _mpps;
        public MonitoringDatasComparingQueryController
            (IMonitoringTestTypeService mtts,
            IMonitoringPointsNumberService mpns,
            IMonitoringPointsPositionService mpps
            )
        {
            _mtts = mtts;
            _mpns = mpns;
            _mpps = mpps;
        }
        public ActionResult DataComparingQuery()
        {
            return View();
        }
        public ActionResult ComparingQuery(MornitoringDataComparingSearchBarView conditions)
        {
            if (conditions.MornitoringPointsNumberIds[0]== conditions.MornitoringPointsNumberIdsSecond[0])
            {
                return Content("<span style='color:red'>对比查询不能选择同一个测点</span>");
            }
            if (conditions.EndTime < conditions.StartTime)
            {
                return Content("<span style='color:red'>开始时间不能晚于结束时间</span>");
            }
            var reqFirst = new DatasQueryResultRequest
            {
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                PointsPositionId = conditions.MornitoringPointsPositionId
            };
            var monitoringDatasQueryServiceFirst = MonitoringDatasEigenvalueQueryServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeId);
            var resultFirst = monitoringDatasQueryServiceFirst.HasQueryResult(reqFirst);
            var reqSecond = new DatasQueryResultRequest
            {
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsNumberIds = conditions.MornitoringPointsNumberIdsSecond,
                PointsPositionId = conditions.MornitoringPointsPositionIdSecond
            };
            var monitoringDatasQueryServiceSecond = MonitoringDatasEigenvalueQueryServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeIdSecond);
            var resultSecond = monitoringDatasQueryServiceSecond.HasQueryResult(reqSecond);
            if (!resultFirst&& resultSecond)
            {
                return Content("<span style='color:red'>所选第一个测点无记录</span>");
            }
            else if (!resultSecond&& resultFirst)
            {
                return Content("<span style='color:red'>所选第二个测点无记录</span>");
            }
            else if(!resultFirst&& !resultSecond)
            {
                return Content("<span style='color:red'>所选测点均无记录</span>");
            }
            return PartialView("DataComparingQuerySearchContentPartial");
        }

        [ChildActionOnly]
        public ActionResult GetDataComparingQuerySearchBar()
        {
            int firstTestTypeId;
            SaveMonitoringTestTypesSelectListItemsToViewData(out firstTestTypeId);
            int tmpMornitoringPointsPositionId;
            SaveMonitoringPointsPositionSelectListItemsToViewData(firstTestTypeId, out tmpMornitoringPointsPositionId);
            SaveMonitoringPointsNumberSelectListItemsToViewData(tmpMornitoringPointsPositionId);
            return PartialView("DataComparingQuerySearchPartial");
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

        public ActionResult GetChartDatasComparing(MornitoringDataComparingSearchBarView conditions)
        {
            var respFirst = new ChartDatasResponse();
            var respSecond = new ChartDatasResponse();
            var reqFirst = new GetChartDatasRequest
            {
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                PointsPositionId = conditions.MornitoringPointsPositionId,
            };
            var reqSecond = new GetChartDatasRequest
            {
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsNumberIds = conditions.MornitoringPointsNumberIdsSecond,
                PointsPositionId = conditions.MornitoringPointsPositionIdSecond,
            };
            var monitoringDatasQueryServiceFirst = MonitoringDatasEigenvalueQueryServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeId);
            var monitoringDatasQueryServiceSecond = MonitoringDatasEigenvalueQueryServiceFactory.GetQueryServiceFrom(conditions.MornitoringTestTypeIdSecond);
            respFirst = monitoringDatasQueryServiceFirst.GetChartDatasBy(reqFirst);
            respSecond = monitoringDatasQueryServiceSecond.GetChartDatasBy(reqSecond);
            var c1 = new ComparingQueryData { MornitoringTestTypeId = conditions.MornitoringTestTypeId, Datas = respFirst.Datas };
            var c2 = new ComparingQueryData { MornitoringTestTypeId = conditions.MornitoringTestTypeIdSecond, Datas = respSecond.Datas };
            return Json(new { c1, c2 }, JsonRequestBehavior.AllowGet);
        }
        public class ComparingQueryData
        {
            public int MornitoringTestTypeId { get; set; }
            public IEnumerable<ChartGroupDataModel> Datas { get; set; }
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
    }
}