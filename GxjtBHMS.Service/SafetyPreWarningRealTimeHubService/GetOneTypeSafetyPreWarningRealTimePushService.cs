using GxjtBHMS.IDAL.SafetyPreWarning;
using GxjtBHMS.Models.SafetyPreWarningTable;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ViewModels.SafetyPreWarning;
using System;
using System.Collections.Generic;

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
            string maxPreWarningState, maxPreWarningColor;
            int maxGradeId;
            foreach (var item in source)
            {
                if (item.ThresholdGradeId == 2)
                {
                    thresholdGrade2Total += 1;
                }
                else if (item.ThresholdGradeId == 3)
                {
                    thresholdGrade3Total += 1;
                }
            }
            if (thresholdGrade3Total > 0)
            {
                maxPreWarningState = ThresholdGrade3;
                maxPreWarningColor = ThresholdGrade3Color;
                maxGradeId = 3;
            }
            else if (thresholdGrade2Total > 0)
            {
                maxPreWarningState = ThresholdGrade2;
                maxPreWarningColor = ThresholdGrade2Color;
                maxGradeId = 2;
            }
            else
            {
                maxPreWarningState = ThresholdGrade1;
                maxPreWarningColor = ThresholdGrade1Color;
                maxGradeId = 1;
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
        public IEnumerable<T> QuerySafetyPreWarningByTime(GetSafetyWarningDetailRequest req)
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
