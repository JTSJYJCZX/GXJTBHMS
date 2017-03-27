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
   public class MonitoringPointsNumberThresholdValueSettingDAL : Repository<MonitoringPointsNumber, int>, IThresholdValueSettingDAL<MonitoringPointsNumber>
    {
    }
}
