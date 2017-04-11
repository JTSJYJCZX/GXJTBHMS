using System;
using System.Collections.Generic;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using GxjtBHMS.SqlServerDAL;
using System.Linq;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningQueryServiceInerfaces;
using GxjtBHMS.Models.SafetyPreWarningTable;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.SafetyPreWarning;

namespace GxjtBHMS.Service.Implementations
{
    public class SafetyPreWarningQueryService<T> : ISafetyPreWarningQueryDetailService<T> where T: SafetyPreWarningBaseModel
    {
        readonly ISafetyPreWarningDetailDAL<T> _safetyPreWarningDetailDAL;
        public SafetyPreWarningQueryService(ISafetyPreWarningDetailDAL<T> safetyPreWarningDetailDAL)
        {
            _safetyPreWarningDetailDAL = safetyPreWarningDetailDAL;
        }

        public IEnumerable<SafetyPreWarningDetailQueryModel> GetSafetyPreWarningDetailSourceBy(IList<Func<T, bool>> ps)
        {

            var source = _safetyPreWarningDetailDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            var datas = new List<SafetyPreWarningDetailQueryModel>();
            foreach (var item in source)
            {
                var result = new SafetyPreWarningDetailQueryModel();
                result.Id = item.Id;
                result.PointsNumber = item.PointsNumber.Name;
                result.Time = item.Time;
                result.MonitoringData = item.MonitoringData;
                result.Unit = item.PointsNumber.PointsPosition.TestType.Unit;
                result.ThresholdValue = item.ThresholdValue;
                result.SafetyPreWarningState = item.ThresholdGrade.ThresholdGrade;
                result.Suggestion = item.ThresholdGrade.Suggest;
                datas.Add(result);
            }
            return datas;
        }

        
    }
}
