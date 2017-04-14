using GxjtBHMS.IDAL.SafetyPreWarning;
using GxjtBHMS.Models.SafetyPreWarningTable;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ViewModels.SafetyPreWarning;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.SafetyPreWarningRealTimeHubService
{
  public class GetOneTypeSafetyPreWarningRealTimePushServiceBase<T> : ServiceBase, IGetOneTypeSafetyPreWarningRealTimePushService<T> where T: SafetyPreWarningBaseModel
    {
        const string ThresholdGrade_NavigationProperty = "ThresholdGrade";
        const string ThresholdGrade1 = "正常";
        const string ThresholdGrade2 = "黄色预警";
        const string ThresholdGrade3 = "红色预警";
        const string ThresholdGrade1Color = "Green";
        const string ThresholdGrade2Color = "Gold";
        const string ThresholdGrade3Color = "Red";
        ISafetyPreWarningRealTimePushDAL<T> _cfspwDAL;
        public GetOneTypeSafetyPreWarningRealTimePushServiceBase(ISafetyPreWarningRealTimePushDAL<T> cfspwDAL)
        {
            _cfspwDAL = cfspwDAL;
        }

        public SafetyPreWarningStateAndTotalTimesModel GetSafetyPreWarningStateModel(GetSafetyWarningDetailRequest req,int testTypeId)
        {
            var source = QuerySafetyPreWarningByTime(req);
            int thresholdGrade2Total=0,thresholdGrade3Total=0;
            string maxPreWarningState= ThresholdGrade1, maxPreWarningColor= ThresholdGrade1Color;
            int maxGradeId= 1;
            foreach (var item in source)
            {
                if (item.ThresholdGradeId == 2)
                {
                    thresholdGrade2Total += 1;
                }
                else
                {
                    thresholdGrade3Total += 1;
                }
            }
            var lastTime = req.EndTime.AddMinutes(-35);
            var systemLastTime = source.Select(m => m.Time).Max();

            if (lastTime<systemLastTime)
            {
                var GetMaxPreWarningStateGradeIdBySystemLastTime = source.Where(m => m.Time == systemLastTime).Select(m => m.ThresholdGradeId).Max();
                maxPreWarningState = source.Where(m => m.Time == systemLastTime).Where(m=>m.ThresholdGradeId== GetMaxPreWarningStateGradeIdBySystemLastTime).Select(m => m.ThresholdGrade.ThresholdGrade).Last();
                maxPreWarningColor = source.Where(m => m.Time == systemLastTime).Where(m => m.ThresholdGradeId == GetMaxPreWarningStateGradeIdBySystemLastTime).Select(m => m.ThresholdGrade.ThresholdColor).Last();
                maxGradeId = source.Where(m => m.Time == systemLastTime).Where(m => m.ThresholdGradeId == GetMaxPreWarningStateGradeIdBySystemLastTime).Select(m => m.ThresholdGradeId).Last();
            }
            return new SafetyPreWarningStateAndTotalTimesModel
            {
                TestTypeId=testTypeId,
                WarningGrade2Times =thresholdGrade2Total,
                WarningGrade3Times =thresholdGrade3Total,
                SafetyPreWarningState =maxPreWarningState,
                SafetyPreWarningColor =maxPreWarningColor,
                GradeId=maxGradeId
            };
        }

        /// <summary>
        /// 通过时间范围查询安全预警结果
        /// </summary>
        /// <param name="req"></param>
        /// <returns></returns>
        IEnumerable<T> QuerySafetyPreWarningByTime(GetSafetyWarningDetailRequest req)
        {
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            DealWithDetailTime(req, ps);
            return _cfspwDAL.FindBy(ps, ThresholdGrade_NavigationProperty);
        }

        void DealWithDetailTime(GetSafetyWarningDetailRequest req, IList<Func<T, bool>> ps)
        {
            ps.Add(m => m.Time >= req.StartTime);
            ps.Add(m => m.Time <= req.EndTime);
        }
    }
}
