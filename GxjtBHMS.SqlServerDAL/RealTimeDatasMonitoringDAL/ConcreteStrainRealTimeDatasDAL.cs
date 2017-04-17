using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class ConcreteStrainRealTimeDatasDAL : Repository<Basic_ConcreteStrainTable , int>, IConcreteStrainRealTimeDatasDAL
    {
        public IEnumerable<Basic_ConcreteStrainTable > GetRealTimeStrains(int pointPositionId)
        {
            List<Basic_ConcreteStrainTable > result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<Basic_ConcreteStrainTable > GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<Basic_ConcreteStrainTable > result = new List<Basic_ConcreteStrainTable >();
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
