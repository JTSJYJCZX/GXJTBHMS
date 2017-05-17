using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
    public class HumidityThresholdValueSettingDAL : Repository<ThresholdValue_HumidityThresholdValueTable, int>, IThresholdValueSettingDAL<ThresholdValue_HumidityThresholdValueTable>
    {
        public override IEnumerable<ThresholdValue_HumidityThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<ThresholdValue_HumidityThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
