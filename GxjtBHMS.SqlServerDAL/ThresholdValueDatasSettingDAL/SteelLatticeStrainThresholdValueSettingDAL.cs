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
   public class SteelLatticeStrainThresholdValueSettingDAL : Repository<SteelLatticeStrainThresholdValueTable, int>,IThresholdValueSettingDAL<SteelLatticeStrainThresholdValueTable>
    {
        public override IEnumerable<SteelLatticeStrainThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<SteelLatticeStrainThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
