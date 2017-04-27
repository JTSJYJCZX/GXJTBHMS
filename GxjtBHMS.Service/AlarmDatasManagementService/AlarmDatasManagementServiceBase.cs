using GxjtBHMS.Models;
using GxjtBHMS.Models.SafetyPreWarningTable;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces;
using GxjtBHMS.Service.Messaging.AlarmDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.MonitoringDatasQueryService
{
    public class AlarmDatasManagementServiceBase<T>:ServiceBase where T : SafetyPreWarningBaseModel
    {
        readonly protected IAlarmDatasQueryService<T> _alarmDatasQueryService;
        readonly protected IAlarmDatasFileSystemService<T> _fileSystemService;
        public AlarmDatasManagementServiceBase()
        {
            _alarmDatasQueryService = new NinjectFactory().GetInstance<IAlarmDatasQueryService<T>>();
            _fileSystemService = new NinjectFactory().GetInstance<IAlarmDatasFileSystemService<T>>();
        }
        protected const string NoRecordsMessage = "无记录！";

        public AlarmDatasResponse GetAlarmDatasBy(GetAlarmDatasRequest req)
        {

            var resp = new AlarmDatasResponse();
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            try
            {
                DealWithConditions(req, ps);
                resp.Datas = _alarmDatasQueryService.GetAlarmDatasSourceBy(ps);
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = ex.Message;
                Log(ex);
            }
            return resp;
        }

        public  bool HasQueryResult(DatasQueryResultRequest req)
        {
            var result = false;
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            try
            {
                DealWithConditions(req, ps);
                var count = _alarmDatasQueryService.GetTotalResultCountBy(ps);
                if (count > 0)
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return result;
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
            ps.Add(m => m.Time >= req.StartTime);
            ps.Add(m => m.Time <= req.EndTime);
        }

        void DealWithContainsPointsNumber(DatasQueryResultRequestBase req, IList<Func<T, bool>> ps)
        {
            if (req.PointsNumberIds != null && req.PointsNumberIds.Length > 0)
            {
                ps.Add(m => req.PointsNumberIds.Contains(m.PointsNumberId));
            }            
        }

        protected void DealWithConditions(DatasQueryResultRequestBase req, IList<Func<T, bool>> ps)
        {
            DealWithEqualPointsPosition(req, ps);
            DealWithSearchTimeRange(req, ps);
            DealWithContainsPointsNumber(req, ps);
        }

        protected bool HasNoSearchResult(IEnumerable<T> source)
        {
            return source.Count() == 0;
        }

    }
}
