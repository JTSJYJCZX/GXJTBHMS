using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
    public class SteelLatticeStrainThresholdValueSettingDAL : Repository<ThresholdValue_SteelLatticeStrainThresholdValueTable, int>,IThresholdValueSettingDAL<ThresholdValue_SteelLatticeStrainThresholdValueTable>
    {
        public override IEnumerable<ThresholdValue_SteelLatticeStrainThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<ThresholdValue_SteelLatticeStrainThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
