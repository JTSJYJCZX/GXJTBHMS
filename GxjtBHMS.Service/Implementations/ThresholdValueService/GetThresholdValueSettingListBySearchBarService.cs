using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service
{
    public class GetThresholdValueSettingListBySearchBarService : ServiceBase
    {
        const string PointsPosition_NavigationProperty = "PointsPosition";
        IThresholdValueSettingDAL<MonitoringPointsNumber> _getPointsPositionDAL;
        IThresholdValueSettingDAL<MonitoringPointsPosition> _getTestTypeDAL;
        public GetThresholdValueSettingListBySearchBarService()
        {
            _getPointsPositionDAL = new NinjectFactory()
                 .GetInstance<IThresholdValueSettingDAL<MonitoringPointsNumber>>();
            _getTestTypeDAL = new NinjectFactory()
                .GetInstance<IThresholdValueSettingDAL<MonitoringPointsPosition>>();
        }

        public IEnumerable<ThresholdValueQueryConditionModel>  GetPointsPositionsByContainPointsNumber(string containPointNumber)
        {
              var  source = QueryThresholdValueListByPointsPosition(containPointNumber);
                var result = new List<ThresholdValueQueryConditionModel>();
                foreach (var item in source)
                {
                    var resultItem = new ThresholdValueQueryConditionModel();                    
                    resultItem.PointsPositionId=item.PointsPositionId;
                    resultItem.PointsName = item.Name;
                    resultItem.TestTypeId = GetTestTypeIdByPointsPosition(item.PointsPositionId);
                    result.Add(resultItem);
                }                
            return result;
        }

        public int GetTestTypeIdByPointsPosition(int pointsPositionId)
        {
          return _getTestTypeDAL.FindBy(m => m.Id == pointsPositionId).SingleOrDefault().TestTypeId;
        }

        public IEnumerable<MonitoringPointsNumber> QueryThresholdValueListByPointsPosition(string containPointNumber)
        {
            IList<Func<MonitoringPointsNumber, bool>> ps = new List<Func<MonitoringPointsNumber, bool>>();
            DealWithContainsPointsNumber(containPointNumber,ps);
            return _getPointsPositionDAL.FindBy(ps, PointsPosition_NavigationProperty);  
        }


        void DealWithContainsPointsNumber(string containPointNumber, IList<Func<MonitoringPointsNumber, bool>> ps)
        {
            if (!string.IsNullOrEmpty(containPointNumber))
            {
                ps.Add(m => m.Name.Contains(containPointNumber));


            }
        }
    }
}
