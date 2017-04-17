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
   public class CableForceThresholdValueSettingDAL : Repository<ThresholdValue_CableForceThresholdValueTable, int>, IThresholdValueSettingDAL<ThresholdValue_CableForceThresholdValueTable>
    {
        public override IEnumerable<ThresholdValue_CableForceThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<ThresholdValue_CableForceThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
