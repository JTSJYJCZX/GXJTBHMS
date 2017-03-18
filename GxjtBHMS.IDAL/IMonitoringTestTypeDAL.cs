using GxjtBHMS.Models;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IMonitoringTestTypeDAL
    {
        IEnumerable<MonitoringTestType> FindAll();
    }
}
