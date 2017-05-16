using GxjtBHMS.IDAL;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class HumidityRealTimeDatasDAL : Repository<RealTime_HumidityTable, int>, IHumidityRealTimeDatasDAL
    {
        public IEnumerable<RealTime_HumidityTable> GetRealTimeHumidity(int pointPositionId)
        {
            List<RealTime_HumidityTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<RealTime_HumidityTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<RealTime_HumidityTable> result = new List<RealTime_HumidityTable>();
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
