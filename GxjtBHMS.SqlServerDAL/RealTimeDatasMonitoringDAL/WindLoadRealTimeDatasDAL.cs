using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class WindLoadRealTimeDatasDAL : Repository<RealTime_WindLoadTable, int>, IWindLoadRealTimeDatasDAL
    {
        public IEnumerable<RealTime_WindLoadTable> GetRealTimeWindLoad(int pointPositionId)
        {
            List<RealTime_WindLoadTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<RealTime_WindLoadTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<RealTime_WindLoadTable> result = new List<RealTime_WindLoadTable>();
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
