using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class ConcreteStrainRealTimeDatasDAL : Repository<ConcreteStrainTable, int>, IConcreteStrainRealTimeDatasDAL
    {
        public IEnumerable<ConcreteStrainTable> GetRealTimeStrains(int pointPositionId)
        {
            List<ConcreteStrainTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<ConcreteStrainTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<ConcreteStrainTable> result = new List<ConcreteStrainTable>();
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
