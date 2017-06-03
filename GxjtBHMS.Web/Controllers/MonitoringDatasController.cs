using GxjtBHMS.Service;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.MonitoringDatasDownloadService;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringPointsNumber;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringPointsPosition;
using GxjtBHMS.Services.ViewModels;
using GxjtBHMS.Web.ExtensionMehtods.MonitoringDatas;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.MonitoringDatas;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    /// <summary>
    /// 监测数据查询控制器
    /// </summary>
    public class MonitoringDatasController : BaseController
    {
        readonly IPreloadDataSet _preloadDataSet;
        public MonitoringDatasController(IPreloadDataSet preloadDataSet)
        {
            _preloadDataSet = preloadDataSet;
        }

        [OutputCache(CacheProfile = "IndexProfile")]
        public ActionResult DataQuery()
        {
            Response.Cache.SetOmitVaryStar(true);
            return View();
        }

        [OutputCache(CacheProfile = "MonitoringDatasQueryProfile")]
        public ActionResult Query(MornitoringDataSearchBarBaseView conditions)
        {
            Response.Cache.SetOmitVaryStar(true);
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
        [OutputCache(CacheProfile = "MonitoringDatasQueryProfile")]
        public ActionResult GetChartDatas(MornitoringDataSearchBarBaseView conditions)
        {
            Response.Cache.SetOmitVaryStar(true);
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
            IEnumerable<SelectListItemModel> testTypeDatas = CacheHelper.GetCache(nameof(PreloadDataSetType.MornitoringTestType)) as IEnumerable<SelectListItemModel>;
            if (testTypeDatas.Any())
            {
                firstTestTypeId = Convert.ToInt32(testTypeDatas.First().Id);
            }
            SaveSelectListItemCollectionToViewData(testTypeDatas, WebConstants.MonitoringTestTypesKey, false);
        }

        /// <summary>
        /// 获得测点位置下拉列表
        /// </summary>
        void SaveMonitoringPointsPositionSelectListItemsToViewData(int mornitoringTestTypeId, out int mornitoringPointsPositionId)
        {
            IEnumerable<MonitoringPointsPositionViewModel> monitoringPointsPositionsDatas = CacheHelper.GetCache(nameof(PreloadDataSetType.MonitoringPointsPositionType)) as IEnumerable<MonitoringPointsPositionViewModel>;

            mornitoringPointsPositionId = 0;

            if (monitoringPointsPositionsDatas.Any())
            {
                mornitoringPointsPositionId = Convert.ToInt32(monitoringPointsPositionsDatas.First().Id);
            }

            SaveSelectListItemCollectionToViewData(monitoringPointsPositionsDatas.Where(m => m.TestTypeId == mornitoringTestTypeId), WebConstants.MonitoringPointsPositionKey, false);
        }

        /// <summary>
        /// 获得测点编号下拉列表
        /// </summary>
        void SaveMonitoringPointsNumberSelectListItemsToViewData(int mornitoringPointsPositionId = 0)
        {
            IEnumerable<MonitoringPointsNumberViewModel> monitoringPointsNumbersDatas = CacheHelper.GetCache(nameof(PreloadDataSetType.MonitoringPointsNumberType)) as IEnumerable<MonitoringPointsNumberViewModel>;
            SaveSelectListItemCollectionToViewData(monitoringPointsNumbersDatas.Where(m => m.PointsPositionId == mornitoringPointsPositionId), WebConstants.MonitoringPointsNumberKey, false);
        }

        [OutputCache(CacheProfile = "ParamIsPointsPositionIdProfile")]
        public ActionResult GetMonitoringPointsNumbersByPointsPositions(int pointsPositions = 0)
        {
            Response.Cache.SetOmitVaryStar(true);
            IList<SelectListItem> selectListItemCollection = new List<SelectListItem>();
            IEnumerable<MonitoringPointsNumberViewModel> monitoringPointsNumberDatas = CacheHelper.GetCache(nameof(PreloadDataSetType.MonitoringPointsNumberType)) as IEnumerable<MonitoringPointsNumberViewModel>;
            selectListItemCollection = monitoringPointsNumberDatas.Where(m => m.PointsPositionId == pointsPositions)
                .ConvertToSelectListItemCollection();
            return Json(selectListItemCollection, JsonRequestBehavior.AllowGet);
        }

        [OutputCache(CacheProfile = "ParamIsTestTypeIdProfile")]
        public ActionResult GetMonitoringPointsPositionsByTestTypeId(int testTypeId = 0)
        {
            Response.Cache.SetOmitVaryStar(true);
            IList<SelectListItem> selectListItemCollection = new List<SelectListItem>();
            IEnumerable<MonitoringPointsPositionViewModel> monitoringPointsPositionsDatas = CacheHelper.GetCache(nameof(PreloadDataSetType.MonitoringPointsPositionType)) as IEnumerable<MonitoringPointsPositionViewModel>;
            selectListItemCollection = monitoringPointsPositionsDatas.Where(m => m.TestTypeId == testTypeId).ConvertToSelectListItemCollection();
            return Json(selectListItemCollection, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 原始数据下载，另存为TXT文档
        /// </summary>
        public void OriginalValueDownloadSearchResult(MornitoringDataSearchBarBaseView conditions)
        {
            var originalValueDownloadService = new OriginalValueDownloadService();
            if (conditions.MornitoringPointsNumberIds == null)
            {
                conditions.MornitoringPointsNumberIds = originalValueDownloadService.GetMonitoringPointsNumberIds(conditions.MornitoringPointsPositionId);
            }
            string downLoadpath = System.Web.HttpContext.Current.Server.MapPath(StyleConstants.MonitoringDatasDownloadPath);
            var req = new DatasQueryResultRequestBase
            {

                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsPositionId = conditions.MornitoringPointsPositionId,
                TestTypeId = conditions.MornitoringTestTypeId
            };
            var resp = originalValueDownloadService.DownloadTxt(req, downLoadpath);
            DownloadFile(resp.FilePath);
        }

        /// <summary>
        /// 特征值下载，另存为TXT文档
        /// </summary>
        public void EigenvalueDownloadSearchResult(MornitoringDataSearchBarBaseView conditions)
        {
            var eigenvalueDownloadService = new EigenvalueDownloadService();
            if (conditions.MornitoringPointsNumberIds == null)
            {
                conditions.MornitoringPointsNumberIds = eigenvalueDownloadService.GetMonitoringPointsNumberIds(conditions.MornitoringPointsPositionId);
            }
            var req = new DatasQueryResultRequestBase
            {
                PointsNumberIds = conditions.MornitoringPointsNumberIds,
                StartTime = conditions.StartTime,
                EndTime = conditions.EndTime,
                PointsPositionId = conditions.MornitoringPointsPositionId,
                TestTypeId = conditions.MornitoringTestTypeId
            };
            string downLoadpath = Server.MapPath(StyleConstants.MonitoringDatasDownloadPath);
            var resp = eigenvalueDownloadService.DownloadTxt(req, downLoadpath);

            DownloadFile(resp.FilePath);
        }

        void DownloadFile(string filePath)
        {
            FileInfo fileInfo = new FileInfo(filePath);

            string fileName = Path.GetFileName(filePath);

            if (fileInfo.Exists)
            {
                const long ChunkSize = 102400;//100K 每次读取文件，只读取100Ｋ，这样可以缓解服务器的压力
                byte[] buffer = new byte[ChunkSize];
                Response.Clear();
                using (FileStream iStream = System.IO.File.OpenRead(filePath))
                {
                    long dataLengthToRead = iStream.Length;//获取下载的文件总大小
                    Response.ContentType = "application/octet-stream";
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(fileName));
                    while (dataLengthToRead > 0 && Response.IsClientConnected)
                    {
                        int lengthRead = iStream.Read(buffer, 0, Convert.ToInt32(ChunkSize));//读取的大小
                        Response.OutputStream.Write(buffer, 0, lengthRead);
                        Response.Flush();
                        dataLengthToRead = dataLengthToRead - lengthRead;
                    }
                    iStream.Close();
                    Response.Close();
                    fileInfo.Delete();
                }
            }
        }
    }
}