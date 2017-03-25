using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging.MonitoringDatas;
using GxjtBHMS.Service.Messaging.MonitoringDatasDownLoad;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations
{
    public abstract class MonitorDatasOringinalValueDownloadServiceBase<T> : MonitoringDatasOriValueServiceBase where T : MonitorDatasQueryConditionsModel
    {

        readonly protected IMonitorDatasQueryFileSystemService<T> _fileSystemService;
        public MonitorDatasOringinalValueDownloadServiceBase()
        {
            _fileSystemService = new NinjectFactory().GetInstance<IMonitorDatasQueryFileSystemService<T>>();
        }

        public override DownLoadDatasResponse SaveAs(DatasQueryResultRequestBase req)
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
