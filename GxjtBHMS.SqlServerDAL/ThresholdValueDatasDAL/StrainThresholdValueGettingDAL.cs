using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
    public class StrainThresholdValueGettingDAL : Repository<StrainThresholdValueTable, int>, IStrainThresholdValueGettingDAL
    {
        public IEnumerable<StrainThresholdValueTable> GetStrainThresholdValue(int pointPositionId)
        {
            MonitoringPointsNumberDAL mpnDAL = new MonitoringPointsNumberDAL();
            var pointsNumberId = mpnDAL.FindBy(m => m.PointsPositionId == pointPositionId).Select(m => m.Id).ToArray();
            List<StrainThresholdValueTable> thresholdValue = new List<StrainThresholdValueTable>();
            foreach (var item in pointsNumberId)
            {
                
                thresholdValue.Add(FindBy(m => m.PointsNumberId == item).First());
            }
            return thresholdValue;
        }
    }

}

