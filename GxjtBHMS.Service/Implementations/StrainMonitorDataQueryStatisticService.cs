using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.Service.ViewModels.DataQueryResult;
using MathNet.Numerics.Statistics;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;

namespace GxjtBHMS.Service.Implementations
{
    class StrainMonitorDataQueryStatisticService : IMonitorDataQueryStatisticService<ConcreteStrainEigenvalueTable>
    {
        readonly IConcreteStrainDatasEigenValueDAL _strainDatasDAL;
        public StrainMonitorDataQueryStatisticService(IConcreteStrainDatasEigenValueDAL strainDatasDAL)
        {
            _strainDatasDAL = strainDatasDAL;
        }

  
    }
}
