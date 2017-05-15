using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
    public class TemperatureThresholdValueSettingDAL : Repository<ThresholdValue_TemperatureThresholdValueTable, int>,IThresholdValueSettingDAL<ThresholdValue_TemperatureThresholdValueTable>
    {
        public override IEnumerable<ThresholdValue_TemperatureThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<ThresholdValue_TemperatureThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
