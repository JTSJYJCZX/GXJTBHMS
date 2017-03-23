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
   public class ConcreteStrainThresholdValueDatasDAL : Repository<ConcreteStrainThresholdValueTable, int>, IConcreteStrainThresholdValueSettingDAL
    {
        public override IEnumerable<ConcreteStrainThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<ConcreteStrainThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
