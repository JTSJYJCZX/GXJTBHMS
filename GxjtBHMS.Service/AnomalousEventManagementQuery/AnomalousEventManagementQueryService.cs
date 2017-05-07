using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Models;
using GxjtBHMS.Models.AnomalousEventTable;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.AnomalousEventManagement;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.AnomalousEventManagementQuery
{
    public class AnomalousEventManagementQueryService : ServiceBase, IAnomalousEventManagementQueryService
    {
        readonly protected IAnomalousEventManagementService _anomalousEventManagementQueryService;
        readonly protected IAnomalousEventManagementsFileSystemService _fileSystemService;
        public AnomalousEventManagementQueryService(IAnomalousEventManagementService anomalousEventManagementQueryService, IAnomalousEventManagementsFileSystemService fileSystemService)
        {
            _anomalousEventManagementQueryService = anomalousEventManagementQueryService;
            _fileSystemService = fileSystemService;
        }
        protected const string NoRecordsMessage = "无记录！";

        public AnomalousEventManagementResponse GetAnomalousEventManagementDatasBy(DatasQueryResultRequestBase req)
        {
            var resp = new AnomalousEventManagementResponse();
            IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps = new List<Func<AnomalousEvent_AnomalousEventTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                resp.Datas = _anomalousEventManagementQueryService.GetAnomalousEventManagementsSourceBy(ps,req.CurrentPageIndex,numberOfResultsPrePage);
                resp.TotalResultCount = _anomalousEventManagementQueryService.GetTotalResultCountBy(ps);
                resp.Succeed = true;
            }
            catch 
            {
                resp.Message = NoRecordsMessage;
            }
            return resp;
        }


        public PagedResponse GetTotalPagesBy(DatasQueryResultRequest req)
        {
            IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps = new List<Func<AnomalousEvent_AnomalousEventTable, bool>>();
            DealWithConditions(req, ps);
            PagedResponse resp = new PagedResponse();
            try
            {
                resp.TotalResultCount = _anomalousEventManagementQueryService.GetTotalResultCountBy(ps);
                if (resp.TotalResultCount <= 0)
                {
                    resp.Message = "无记录!";
                }
                else
                {
                    resp.Succeed = true;
                }
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return resp;
        }


        public DownLoadDatasResponse SaveAs(DatasQueryResultRequestBase req)
        {
            var resp = new DownLoadDatasResponse();
            IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps = new List<Func<AnomalousEvent_AnomalousEventTable, bool>>();
            try
            {
                DealWithConditions(req, ps);
                resp.Datas = _fileSystemService.ConvertToDocument(ps);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "无法下载数据";
                Log(ex);
            }
            return resp;
        }

        void DealWithEqualPointsPosition(DatasQueryResultRequestBase req, IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps)
        {
            if (req.PointsPositionId > 0)
            {
                ps.Add(m => m.PointsNumber.PointsPositionId == req.PointsPositionId);
            }
        }
        void DealWithSearchTimeRange(DatasQueryResultRequestBase req, IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps)
        {
            if (req.StartTime.Year != 1)
            {
                ps.Add(m => m.Time >= req.StartTime);
                ps.Add(m => m.Time <= req.EndTime);
            }

        }


        protected void DealWithConditions(DatasQueryResultRequestBase req, IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps)
        {
            DealWithEqualPointsPosition(req, ps);
            DealWithSearchTimeRange(req, ps);
        }

        protected bool HasNoSearchResult(IEnumerable<AnomalousEvent_AnomalousEventTable> source)
        {
            return source.Count() == 0;
        }


        public AnomalousEventManagementResponse GetAnomalousEventByTime(DatasQueryResultRequestBase req)
        {
            var resp = new AnomalousEventManagementResponse();
            IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps = new List<Func<AnomalousEvent_AnomalousEventTable, bool>>();
            DealWithSearchTime(req, ps);               
            resp.Datas = _anomalousEventManagementQueryService.GetAnomalousEventSourceBy(ps);
            return resp;
        }

        /// <summary>
        /// 主页搜索数量用的时间条件
        /// </summary>
        /// <param name="req"></param>
        /// <param name="ps"></param>
        void DealWithSearchTime(DatasQueryResultRequestBase req, IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps)
        {
                ps.Add(m => m.Time >=req.StartTime);
        }
    }
}
