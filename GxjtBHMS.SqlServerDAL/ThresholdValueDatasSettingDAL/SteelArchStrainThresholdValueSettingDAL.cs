using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Models.ThresholdValueSetting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
   public class SteelArchStrainThresholdValueSettingDAL : Repository<SteelArchStrainThresholdValueTable, int>,IThresholdValueSettingDAL<SteelArchStrainThresholdValueTable>
    {
        public override IEnumerable<SteelArchStrainThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<SteelArchStrainThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
