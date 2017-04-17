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
