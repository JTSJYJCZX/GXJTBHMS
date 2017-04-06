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
        IMonitoringPointsNumberDAL _getPointsPositionDAL;
        IMonitoringPointsPositionDAL _getTestTypeDAL;
        public GetThresholdValueSettingListBySearchBarService()
        {
            _getPointsPositionDAL = new NinjectFactory()
                 .GetInstance<IMonitoringPointsNumberDAL>();
            _getTestTypeDAL = new NinjectFactory()
                .GetInstance<IMonitoringPointsPositionDAL>();
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
            DealWithContainsPointsNumberToUpper(containPointNumber,ps);
            return _getPointsPositionDAL.FindBy(ps, PointsPosition_NavigationProperty);  
        }

        /// <summary>
        /// 处理查询条件中包含测点编号字符串
        /// </summary>
        /// <param name="containPointNumber"></param>
        /// <param name="ps"></param>
        void DealWithContainsPointsNumber(string containPointNumber, IList<Func<MonitoringPointsNumber, bool>> ps)
        {
            if (!string.IsNullOrEmpty(containPointNumber))
            {
                ps.Add(m => m.Name.Contains(containPointNumber));
            }
        }

        /// <summary>
        /// 处理查询条件包含测点编号字符串，且匹配字段转换成大写，查询条件也转换成大写
        /// </summary>
        /// <param name="containPointNumber"></param>
        /// <param name="ps"></param>
        void DealWithContainsPointsNumberToUpper(string containPointNumber, IList<Func<MonitoringPointsNumber, bool>> ps)
        {
            if (!string.IsNullOrEmpty(containPointNumber))
            {
                ps.Add(m => m.Name.ToUpper().Contains(containPointNumber.ToUpper()));
            }
        }
    }
}
