using GxjtBHMS.Infrastructure.Domain;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Models.RealTimeMonitoringDatas;
using System.Collections.Generic;

namespace GxjtBHMS.IDAL
{
    public interface IConcreteStrainDatasEigenValueDAL: IReadOnlyRepository<ConcreteStrainEigenvalueTable, int>
    {

    }
}
