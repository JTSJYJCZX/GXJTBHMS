using GxjtBHMS.IDAL.AlarmDatasManagement;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models.SafetyPreWarningTable;
using GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces;
using GxjtBHMS.Service.ViewModels.AlarmDatasModel;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations.AlarmDatasManagement
{
    public class AlarmDatasQueryService<T> : IAlarmDatasQueryService<T> where T : SafetyPreWarningBaseModel
    {
        readonly IAlarmDatasQueryDAL<T> _alarmDatasQueryDAL;
        public AlarmDatasQueryService(IAlarmDatasQueryDAL<T> alarmDatasQueryDAL)
        {
            _alarmDatasQueryDAL = alarmDatasQueryDAL;
        }

        public IEnumerable<AlarmDatasModel> GetAlarmDatasSourceBy(IList<Func<T, bool>> ps, int currentPageIndex, int pageSize)
        {
            string[] navigationProperties = { ServiceConstant.PointsNumberPointsPositionNavigationProperty, ServiceConstant.ThresholdGradeNavigationProperty };
            var source = _alarmDatasQueryDAL.FindBy(ps, currentPageIndex, pageSize,navigationProperties);
            //var groupDatas = source.GroupBy(m => m.PointsNumber.Name);
            var datas = new List<AlarmDatasModel>();
            var models = source.OrderBy(m => m.Time).Select(m => new AlarmDatasModel { Time = DateTimeHelper.FormatDateTime(m.Time), TestType = m.PointsNumber.PointsPosition.TestType.Name,PointsPosition=m.PointsNumber.PointsPosition.Name, PointsNumber = m.PointsNumber.Name, MonitoringData = m.MonitoringData, ThresholdValue = m.ThresholdValue, ThresholdGrade = m.ThresholdGrade.ThresholdGrade,Unit=m.PointsNumber.PointsPosition.TestType.Unit});
            datas = models.ToList();

            //foreach (var group in groupDatas)
            //{
            //    var models = group.OrderBy(m => m.Time).Select(m => new AlarmDatasModel {Time = DateTimeHelper.FormatDateTime(m.Time), TestType = m.PointsNumber.PointsPosition.TestType.Name, PointsNumber = m.PointsNumber.Name, MonitoringData =m.MonitoringData, ThresholdValue=m.ThresholdValue, ThresholdGrade=m.ThresholdGrade.ThresholdGrade, });
            //    //var unit = group.FirstOrDefault().PointsNumber.PointsPosition.TestType.Unit;
            //    datas.Add(new AlarmDatasModel { Models = models});
            //}
            return datas;
        }

        public long GetTotalResultCountBy(IList<Func<T, bool>> ps)
        {
            return _alarmDatasQueryDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }


    }
}

