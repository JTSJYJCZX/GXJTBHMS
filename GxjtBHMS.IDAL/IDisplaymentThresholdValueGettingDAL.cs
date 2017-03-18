using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models.ThresholdValueSetting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.IDAL
{
    public interface IDisplaymentThresholdValueGettingDAL : IReadOnlyRepository<DisplaymentThresholdValueTable, int>, IRepository<DisplaymentThresholdValueTable>
    {
        IEnumerable<DisplaymentThresholdValueTable> GetDisplaymentThresholdValue(int pointPositionId);
    }
}
