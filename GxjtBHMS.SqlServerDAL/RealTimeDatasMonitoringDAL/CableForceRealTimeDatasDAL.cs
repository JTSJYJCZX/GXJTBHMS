using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class CableForceRealTimeDatasDAL : Repository<CableForceTable, int>, ICableForceRealTimeDatasDAL
    {
        public IEnumerable<CableForceTable> GetRealTimeCableForce(int pointPositionId)
        {
            List<CableForceTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<CableForceTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<CableForceTable> result = new List<CableForceTable>();
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
