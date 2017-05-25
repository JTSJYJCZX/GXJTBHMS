using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Interfaces.MonitoringDatasQueryServiceInerfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.MonitoringDatasQueryService
{
    public class MonitorDatasEigenvalueQueryServiceBase<T>:ServiceBase where T : MonitorDatasQueryConditionsModel
    {
        readonly protected IMonitorDatasEigenvalueQueryChartService<T> _chartService;
        public MonitorDatasEigenvalueQueryServiceBase()
        {
            _chartService = new NinjectFactory().GetInstance<IMonitorDatasEigenvalueQueryChartService<T>>();
        }
        protected const string NoRecordsMessage = "无记录！";

        public  ChartDatasResponse GetChartDatasBy(GetChartDatasRequest req)
        {

            var resp = new ChartDatasResponse();
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            try
            {
                DealWithConditions(req, ps);
                resp.Datas = _chartService.GetChartDataSourceBy(ps);
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
                var count = _chartService.GetTotalResultCountBy(ps);
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
    }
}
