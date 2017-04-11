using GxjtBHMS.Models.SafetyPreWarningTable;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningQueryServiceInerfaces;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.SafetyPreWarning;
using GxjtBHMS.SqlServerDAL;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.SafetyPreWarningQueryService
{
    public class SafetyPreWarningQueryServiceBase<T>:ServiceBase where T : SafetyPreWarningBaseModel
    {
        const string PointsNumber_NavigationProperty = "PointsNumber.PointsPosition.TestType";
        ISafetyPreWarningDetailDAL<T> _safetyPreWarningDetailDAL;
        public SafetyPreWarningQueryServiceBase()
        {
            _safetyPreWarningDetailDAL = new NinjectFactory().GetInstance<ISafetyPreWarningDetailDAL<T>>();          
        }
        protected const string NoRecordsMessage = "无记录！";

        public SafetyWarningDetailResponse GetSafetyPreWarningDetailBy(GetSafetyWarningDetailRequest req)
        {
            var resp = new SafetyWarningDetailResponse();
            try
            {
                var source = QuerySafetyPreWarningByTime(req);
                var result = new List<SafetyPreWarningDetailQueryModel>();
                foreach (var item in source)
                {
                    var resultItem = new SafetyPreWarningDetailQueryModel();
                    resultItem.Id = item.Id;
                    resultItem.PointsNumber = item.PointsNumber.Name;
                    resultItem.Time = item.Time;
                    resultItem.MonitoringData = item.MonitoringData;
                    resultItem.Unit = item.PointsNumber.PointsPosition.TestType.Unit;
                    resultItem.ThresholdValue = item.ThresholdValue;
                    resultItem.SafetyPreWarningState = item.SafetyPreWarningState;
                    resultItem.Suggestion = item.Suggestion;
                    result.Add(resultItem);
                }
                if (HasNoSearchResult(result))
                {
                    resp.Message = "无记录！";
                }
                else
                {
                    resp.Datas = result;
                    resp.Succeed = true;
                }
            }
            catch (Exception ex)
            {
                resp.Message = "搜索阈值列表信息发生错误！";
                Log(ex);
            }
            return resp;
        }

        /// <summary>
        /// 通过时间范围查询安全预警结果
        /// </summary>
        /// <param name="req"></param>
        /// <returns></returns>
        public IEnumerable<T> QuerySafetyPreWarningByTime(GetSafetyWarningDetailRequest req)
        {
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            DealWithDetailTime(req, ps);
            return _safetyPreWarningDetailDAL.FindBy(ps, PointsNumber_NavigationProperty);
        }

        void DealWithDetailTime(GetSafetyWarningDetailRequest req, IList<Func<T, bool>> ps)
        {
            ps.Add(m => m.Time >= req.StartTime);
            ps.Add(m => m.Time <= req.EndTime);
        }

        protected bool HasNoSearchResult(IEnumerable<SafetyPreWarningDetailQueryModel> source)
        {
            return source.Count() == 0;
        }

    }
}
