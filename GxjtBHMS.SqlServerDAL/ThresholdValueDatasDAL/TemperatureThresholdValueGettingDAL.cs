using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
    public class TemperatureThresholdValueGettingDAL : Repository<TemperatureThresholdValueTable, int>, ITemperatureThresholdValueGettingDAL
    {
        public IEnumerable<TemperatureThresholdValueTable> GetTemperatureThresholdValue(int pointPositionId)
        {
            MonitoringPointsNumberDAL mpnDAL = new MonitoringPointsNumberDAL();
            var pointsNumberId = mpnDAL.FindBy(m => m.PointsPositionId == pointPositionId).Select(m => m.Id).ToArray();
            List<TemperatureThresholdValueTable> thresholdValue = new List<TemperatureThresholdValueTable>();
            foreach (var item in pointsNumberId)
            {
                thresholdValue.Add(FindBy(m => m.PointsNumberId == item).First());
            }
            return thresholdValue;
        }
    }
}
