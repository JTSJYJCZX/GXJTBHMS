using GxjtBHMS.IDAL;
using GxjtBHMS.Models.RealTimeMonitoringDataTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class ConcreteStrainRealTimeDatasDAL : Repository<RealTime_ConcreteStrainTable, int>, IConcreteStrainRealTimeDatasDAL
    {
        public IEnumerable<RealTime_ConcreteStrainTable> GetRealTimeStrains(int pointPositionId)
        {
            List<RealTime_ConcreteStrainTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<RealTime_ConcreteStrainTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<RealTime_ConcreteStrainTable> result = new List<RealTime_ConcreteStrainTable>();
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
