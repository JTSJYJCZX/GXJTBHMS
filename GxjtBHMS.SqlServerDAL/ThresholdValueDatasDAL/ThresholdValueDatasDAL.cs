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
   public class ThresholdValueDatasDAL : Repository<StrainThresholdValueTable, int>, IThresholdValueSettingDAL
    {
        public override IEnumerable<StrainThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<StrainThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
