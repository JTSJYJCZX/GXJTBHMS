using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces;
using GxjtBHMS.Service.Interfaces.MonitoringDatasQueryServiceInerfaces;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.AlarmDatas;
using GxjtBHMS.Service.Messaging.AnomalousEventManagement;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.AnomalousEventManagementQueryService
{
    public class AnomalousEventManagementQueryServiceBase<T> : ServiceBase where T : MonitorDatasQueryConditionsModel
    {
        readonly protected IAnomalousEventManagementQueryService<T> _anomalousEventManagementQueryService;
        readonly protected IAnomalousEventManagementsFileSystemService<T> _fileSystemService;
        public AnomalousEventManagementQueryServiceBase()
        {
            _anomalousEventManagementQueryService = new NinjectFactory().GetInstance<IAnomalousEventManagementQueryService<T>>();
            _fileSystemService = new NinjectFactory().GetInstance<IAnomalousEventManagementsFileSystemService<T>>();
        }
        protected const string NoRecordsMessage = "无记录！";

        public AnomalousEventManagementResponse GetAnomalousEventManagementDatasBy(DatasQueryResultRequestBase req)
        {

            var resp = new AnomalousEventManagementResponse();
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            try
            {
                DealWithConditions(req, ps);
                var numberOfResultsPrePage = ApplicationSettingsFactory.GetApplicationSettings().NumberOfResultsPrePage;//获取每页记录数
                resp.Datas = _anomalousEventManagementQueryService.GetAnomalousEventManagementsSourceBy(ps, req.CurrentPageIndex, numberOfResultsPrePage);
                resp.TotalResultCount = _anomalousEventManagementQueryService.GetTotalResultCountBy(ps);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = ex.Message;
                Log(ex);
            }
            return resp;
        }

        public PagedResponse GetTotalPagesBy(DatasQueryResultRequest req)
        {
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
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
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
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

        void DealWithEqualPointsPosition(DatasQueryResultRequestBase req, IList<Func<T, bool>> ps)
        {
            if (req.PointsPositionId > 0)
            {
                ps.Add(m => m.PointsNumber.PointsPositionId == req.PointsPositionId);
            }
        }
        void DealWithSearchTimeRange(DatasQueryResultRequestBase req, IList<Func<T, bool>> ps)
        {
            if (req.StartTime.Year != 1)
            {
                ps.Add(m => m.Time >= req.StartTime);
                ps.Add(m => m.Time <= req.EndTime);
            }

        }


        protected void DealWithConditions(DatasQueryResultRequestBase req, IList<Func<T, bool>> ps)
        {
            DealWithEqualPointsPosition(req, ps);
            DealWithSearchTimeRange(req, ps);
        }

        protected bool HasNoSearchResult(IEnumerable<T> source)
        {
            return source.Count() == 0;
        }

    }
}
