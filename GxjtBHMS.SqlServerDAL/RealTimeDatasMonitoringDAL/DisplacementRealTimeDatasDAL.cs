using GxjtBHMS.IDAL;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class DisplacementRealTimeDatasDAL : Repository<RealTime_DisplacementTable, int>, IDisplacementRealTimeDatasDAL
    {
        public IEnumerable<RealTime_DisplacementTable> GetRealTimeDisplacement(int pointPositionId)
        {
            List<RealTime_DisplacementTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<RealTime_DisplacementTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<RealTime_DisplacementTable> result = new List<RealTime_DisplacementTable>();
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
