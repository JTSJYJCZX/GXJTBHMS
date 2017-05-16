using GxjtBHMS.IDAL;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class CableForceRealTimeDatasDAL : Repository<RealTime_CableForceTable, int>, ICableForceRealTimeDatasDAL
    {
        public IEnumerable<RealTime_CableForceTable> GetRealTimeCableForce(int pointPositionId)
        {
            List<RealTime_CableForceTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<RealTime_CableForceTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<RealTime_CableForceTable> result = new List<RealTime_CableForceTable>();
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
