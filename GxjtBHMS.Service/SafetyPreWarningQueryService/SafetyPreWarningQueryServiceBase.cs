using GxjtBHMS.Models.SafetyPreWarningTable;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.SafetyPreWarning;
using GxjtBHMS.SqlServerDAL;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.SafetyPreWarningQueryService
{
    public class SafetyPreWarningQueryServiceBase<T> : ServiceBase where T : SafetyPreWarningBaseModel
    {
        const string PointsNumber_NavigationProperty = "PointsNumber.PointsPosition.TestType";
        const string ThresholdGrade_NavigationProperty = "ThresholdGrade";
        ISafetyPreWarningDetailDAL<T> _safetyPreWarningDetailDAL;
        public SafetyPreWarningQueryServiceBase()
        {
            _safetyPreWarningDetailDAL = new NinjectFactory().GetInstance<ISafetyPreWarningDetailDAL<T>>();
        }
        protected const string NoRecordsMessage = "无记录！";


        public SafetyWarningDetailResponse GetSafetyPreWarningDetailBy(GetSafetyWarningDetailRequest req)
        {
            var resp = new SafetyWarningDetailResponse();
           var source = QuerySafetyPreWarningByTime(req);
            if (HasQueryResult(req))
            {
                var result = new List<SafetyPreWarningDetailQueryModel>();
                foreach (var item in source)
                {
                    var resultItem = new SafetyPreWarningDetailQueryModel();
                    resultItem.PointsNumber = item.PointsNumber.Name;
                    resultItem.Time = item.Time;
                    resultItem.MonitoringData = item.MonitoringData;
                    resultItem.Unit = item.PointsNumber.PointsPosition.TestType.Unit;
                    resultItem.ThresholdValue = item.ThresholdValue;
                    resultItem.SafetyPreWarningState = item.ThresholdGrade.ThresholdGrade;
                    resultItem.Suggestion = item.ThresholdGrade.Suggest;
                    result.Add(resultItem);
                }
                resp.Datas = result;
                resp.Succeed = true;
            }
            else
            {
                resp.Succeed = false;
                resp.Message = NoRecordsMessage;
            }
            return resp;
        }

        public bool HasQueryResult(GetSafetyWarningDetailRequest req)
        {
            var result = false;
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            try
            {               
                var count = QuerySafetyPreWarningByTime(req).Count();
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


        //public IEnumerable<SafetyPreWarningDetailQueryModel>  GetSafetyPreWarningDetail(GetSafetyWarningDetailRequest req)
        //{
        //        var source = QuerySafetyPreWarningByTime(req);
        //        var result = new List<SafetyPreWarningDetailQueryModel>();
        //        foreach (var item in source)
        //        {
        //            var resultItem = new SafetyPreWarningDetailQueryModel();
        //            //resultItem.Id = item.Id;
        //            resultItem.PointsNumber = item.PointsNumber.Name;
        //            resultItem.Time = item.Time;
        //            resultItem.MonitoringData = item.MonitoringData;
        //            resultItem.Unit = item.PointsNumber.PointsPosition.TestType.Unit;
        //            resultItem.ThresholdValue = item.ThresholdValue;
        //            resultItem.SafetyPreWarningState = item.ThresholdGrade.ThresholdGrade;
        //            resultItem.Suggestion = item.ThresholdGrade.Suggest;
        //            result.Add(resultItem);
        //        }               
        //    return result;
        //}

        /// <summary>
        /// 通过时间范围查询安全预警结果
        /// </summary>
        /// <param name="req"></param>
        /// <returns></returns>
        public IEnumerable<T> QuerySafetyPreWarningByTime(GetSafetyWarningDetailRequest req)
        {
            string[] navigationProperty = { PointsNumber_NavigationProperty, ThresholdGrade_NavigationProperty };
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            DealWithDetailTime(req, ps);
            return _safetyPreWarningDetailDAL.FindBy(ps, navigationProperty);
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

        //public SafetyPreWarningStateAndTotalTimesModel GetSafetyPreWarningStateAndTotalTimes(GetSafetyWarningDetailRequest req)
        //{
        //    var source = QuerySafetyPreWarningByTime(req);
        //    var result = new SafetyPreWarningStateAndTotalTimesModel();
        //    result.WarningGrade2Times=
        //    return null;
        //}

    }
}
