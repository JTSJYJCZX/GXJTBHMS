using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Models.RealTimeMonitoringDatas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.IDAL
{
    public interface IRealTimeStrainDatasDAL:IReadOnlyRepository<ConcreteStrainTable, int>
    {
        IEnumerable<RealTimeStrainModel> GetRealTimeStrains(int pointPositionId);
    }
}
