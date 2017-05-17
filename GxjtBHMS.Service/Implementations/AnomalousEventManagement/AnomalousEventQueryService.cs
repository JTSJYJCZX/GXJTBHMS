using GxjtBHMS.IDAL.AnomalousEventIDAL;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models.AnomalousEventTable;
using GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces;
using GxjtBHMS.Service.ViewModels.AnomalousEventManagement;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations.AlarmDatasManagement
{
    public class AnomalousEventQueryService: IAnomalousEventManagementService
    {
        readonly IAnomalousEventQueryDAL _anomalousEventDAL;
        public AnomalousEventQueryService(IAnomalousEventQueryDAL anomalousEventDAL)
        {
            _anomalousEventDAL = anomalousEventDAL;
        }


        public IEnumerable<AnomalousEventManagementModel> GetAnomalousEventManagementsSourceBy(IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps, int currentPageIndex, int pageSize)
        {
            string[] navigationProperties = { ServiceConstant.PointsNumberPointsPositionNavigationProperty, ServiceConstant.AnomalousEventReasonNavigationProperty };
            var source = _anomalousEventDAL.FindBy(ps, currentPageIndex, pageSize,navigationProperties);
            var datas = new List<AnomalousEventManagementModel>();
            var models = source.OrderBy(m => m.Id).Select(m => new AnomalousEventManagementModel { Time = DateTimeHelper.FormatDateTime(m.Time), TestType = m.PointsNumber.PointsPosition.TestType.Name,PointsPosition=m.PointsNumber.PointsPosition.Name, PointsNumber = m.PointsNumber.Name, AnomalousEventReason=m.AnomalousEventReason.AnomalousEventReason});
            datas = models.ToList();
            return datas;
        }



        public long GetTotalResultCountBy(IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps)
        {
            return _anomalousEventDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }


        /// <summary>
        /// 主页查询数量用
        /// </summary>
        /// <param name="ps"></param>
        /// <returns></returns>
        public IEnumerable<AnomalousEventManagementModel> GetAnomalousEventSourceBy(IList<Func<AnomalousEvent_AnomalousEventTable, bool>> ps)
        {
            string[] navigationProperties = { ServiceConstant.PointsNumberPointsPositionNavigationProperty, ServiceConstant.AnomalousEventReasonNavigationProperty };
            var source = _anomalousEventDAL.FindBy(ps,navigationProperties).ToList();
            var datas = new List<AnomalousEventManagementModel>();
            var models = source.Select(m => new AnomalousEventManagementModel {TestType = m.PointsNumber.PointsPosition.TestType.Name});
            datas = models.ToList();
            return datas;
        }


    }
}

