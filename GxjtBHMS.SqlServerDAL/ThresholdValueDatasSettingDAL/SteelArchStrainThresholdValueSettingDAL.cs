using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
    public class SteelArchStrainThresholdValueSettingDAL : Repository<ThresholdValue_SteelArchStrainThresholdValueTable, int>,IThresholdValueSettingDAL<ThresholdValue_SteelArchStrainThresholdValueTable>
    {
        public override IEnumerable<ThresholdValue_SteelArchStrainThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<ThresholdValue_SteelArchStrainThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
