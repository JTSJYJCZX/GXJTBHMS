using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
    public class CableForceThresholdValueGettingDAL : Repository<CableForceThresholdValueTable, int>, ICableForceThresholdValueGettingDAL
    {
        public IEnumerable<CableForceThresholdValueTable> GetCableForceThresholdValue(int pointPositionId)
        {
            MonitoringPointsNumberDAL mpnDAL = new MonitoringPointsNumberDAL();
            var pointsNumberId = mpnDAL.FindBy(m => m.PointsPositionId == pointPositionId).Select(m => m.Id).ToArray();
            List<CableForceThresholdValueTable> thresholdValue = new List<CableForceThresholdValueTable>();
            foreach (var item in pointsNumberId)
            {
                thresholdValue.Add(FindBy(m => m.PointsNumberId == item).First());
            }
            return thresholdValue;
        }
    }
}
