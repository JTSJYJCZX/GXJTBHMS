using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.ThresholdValueSetting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.IDAL
{
  public  interface IHumidityThresholdValueGettingDAL: IReadOnlyRepository<HumidityThresholdValueTable, int>, IRepository<HumidityThresholdValueTable>
    {
        IEnumerable<HumidityThresholdValueTable> GetHumidityThresholdValue(int pointPositionId);
    }
}
