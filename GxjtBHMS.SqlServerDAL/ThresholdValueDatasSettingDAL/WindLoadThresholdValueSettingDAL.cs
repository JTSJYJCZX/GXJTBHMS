using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
    public class WindLoadThresholdValueSettingDAL : Repository<ThresholdValue_WindLoadThresholdValueTable, int>, IThresholdValueSettingDAL<ThresholdValue_WindLoadThresholdValueTable>
    {
        public override IEnumerable<ThresholdValue_WindLoadThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<ThresholdValue_WindLoadThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
