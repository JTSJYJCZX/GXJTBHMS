using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
    public class HumidityThresholdValueGettingDAL : Repository<HumidityThresholdValueTable, int>, IHumidityThresholdValueGettingDAL
    {
        public IEnumerable<HumidityThresholdValueTable> GetHumidityThresholdValue(int pointPositionId)
        {
            MonitoringPointsNumberDAL mpnDAL = new MonitoringPointsNumberDAL();
            var pointsNumberId = mpnDAL.FindBy(m => m.PointsPositionId == pointPositionId).Select(m => m.Id).ToArray();
            List<HumidityThresholdValueTable> thresholdValue = new List<HumidityThresholdValueTable>();
            foreach (var item in pointsNumberId)
            {
                thresholdValue.Add(FindBy(m => m.PointsNumberId == item).First());
            }
            return thresholdValue;
        }
    }
}
