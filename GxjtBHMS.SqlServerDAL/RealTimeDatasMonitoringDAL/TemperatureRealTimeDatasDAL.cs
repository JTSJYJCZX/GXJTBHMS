using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class TemperatureRealTimeDatasDAL : Repository<TemperatureTable, int>, ITemperatureRealTimeDatasDAL
    {
        public IEnumerable<TemperatureTable> GetRealTimeTemperature(int pointPositionId)
        {
            List<TemperatureTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<TemperatureTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<TemperatureTable> result = new List<TemperatureTable>();
            var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
            foreach (var item in pointsNumberId)
            {
                string[] navigationProperty = { DALConstant.PointsNumberPointsPositionNavigationProperty, DALConstant.ThresholdGradeNavigationProperty };
                var sorce = FindBy(m => m.PointsNumberId == item, navigationProperty).Last();
                result.Add(sorce);
            }
            return result;
        }

        int[] GetPointsNumberIdByPointsPositionId(int pointPositionId)
        {
            MonitoringPointsNumberDAL mpnDAL = new MonitoringPointsNumberDAL();
            return mpnDAL.FindBy(m => m.PointsPositionId == pointPositionId).Select(m => m.Id).ToArray();
        }

       
    }
}
