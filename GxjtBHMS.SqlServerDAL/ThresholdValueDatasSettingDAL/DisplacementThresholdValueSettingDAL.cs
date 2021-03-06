﻿using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL
{
    public class DisplacementThresholdValueSettingDAL : Repository<ThresholdValue_DisplacementThresholdValueTable, int>,IThresholdValueSettingDAL<ThresholdValue_DisplacementThresholdValueTable>
    {
        public override IEnumerable<ThresholdValue_DisplacementThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<ThresholdValue_DisplacementThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
