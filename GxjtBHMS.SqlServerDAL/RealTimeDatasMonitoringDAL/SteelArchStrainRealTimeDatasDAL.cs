using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class SteelArchStrainRealTimeDatasDAL : Repository<SteelArchStrainTable, int>, ISteelArchStrainRealTimeDatasDAL
    {
        public IEnumerable<SteelArchStrainTable> GetRealTimeStrains(int pointPositionId)
        {
            List<SteelArchStrainTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<SteelArchStrainTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<SteelArchStrainTable> result = new List<SteelArchStrainTable>();
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
