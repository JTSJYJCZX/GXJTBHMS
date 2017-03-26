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
   public class WindLoadThresholdValueSettingDAL : Repository<WindLoadThresholdValueTable, int>, IThresholdValueSettingDAL<WindLoadThresholdValueTable>
    {
        public override IEnumerable<WindLoadThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<WindLoadThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
