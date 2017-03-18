using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations
{
    public abstract class MonitorDatasEigenvalueQueryServiceBase<T> : ServiceBase where T : MonitorDatasQueryConditionsModel
    {
        readonly protected IMonitorDatasEigenvalueQueryChartService<T> _chartService;
        readonly protected IMonitorDatasEigenvalueQueryFileSystemService<T> _fileSystemService;
        public MonitorDatasEigenvalueQueryServiceBase(IMonitorDatasEigenvalueQueryChartService<T> chartService, 
            IMonitorDatasEigenvalueQueryFileSystemService<T> fileSystemService
            )
        {
            _chartService = chartService;
            _fileSystemService = fileSystemService;
        }

        protected const string NoRecordsMessage = "无记录！";
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
