using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class SteelLatticeStrainRealTimeDatasDAL : Repository<Basic_SteelLatticeStrainTable , int>,ISteelLatticeStrainRealTimeDatasDAL
    {
        public IEnumerable<Basic_SteelLatticeStrainTable > GetRealTimeStrains(int pointPositionId)
        {
            List<Basic_SteelLatticeStrainTable > result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<Basic_SteelLatticeStrainTable > GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<Basic_SteelLatticeStrainTable > result = new List<Basic_SteelLatticeStrainTable >();
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
