using GxjtBHMS.IDAL;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class TemperatureRealTimeDatasDAL : Repository<RealTime_TemperatureTable, int>, ITemperatureRealTimeDatasDAL
    {
        public IEnumerable<RealTime_TemperatureTable> GetRealTimeTemperature(int pointPositionId)
        {
            List<RealTime_TemperatureTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<RealTime_TemperatureTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<RealTime_TemperatureTable> result = new List<RealTime_TemperatureTable>();
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
