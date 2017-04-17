﻿using GxjtBHMS.IDAL;
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
   public class ConcreteStrainThresholdValueSettingDAL : Repository<ThresholdValue_ConcreteStrainThresholdValueTable, int>, IThresholdValueSettingDAL<ThresholdValue_ConcreteStrainThresholdValueTable>
    {
        public override IEnumerable<ThresholdValue_ConcreteStrainThresholdValueTable> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<ThresholdValue_ConcreteStrainThresholdValueTable>().Include("PointsNumber").ToList();
            }
        }
    }
}
