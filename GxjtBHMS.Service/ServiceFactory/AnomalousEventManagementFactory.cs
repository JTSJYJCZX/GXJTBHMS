using GxjtBHMS.Models.AnomalousEventTable;
using GxjtBHMS.Service.AnomalousEventManagementQueryService;
using GxjtBHMS.Service.MonitoringDatasQueryService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Service.ServiceFactory
{
   public class AnomalousEventManagementFactory
    {
        public static dynamic GetQueryServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                case 1:
                    return new AnomalousEventManagementQueryServiceBase<AnomalousEvent_SteelArchStrainTable>();
                case 2:
                    return new AnomalousEventManagementQueryServiceBase<AnomalousEvent_SteelLatticeStrainTable>();
                case 3:
                    return new AnomalousEventManagementQueryServiceBase<AnomalousEvent_ConcreteStrainTable>();
                case 4:
                    return new AnomalousEventManagementQueryServiceBase<AnomalousEvent_DisplacementTable>();
                case 5:
                    return new AnomalousEventManagementQueryServiceBase<AnomalousEvent_CableForceTable>();
                case 6:
                    return new AnomalousEventManagementQueryServiceBase<AnomalousEvent_HumidityTable>();
                case 7:
                    return new AnomalousEventManagementQueryServiceBase<AnomalousEvent_TemperatureTable>();
                case 8:
                    return new AnomalousEventManagementQueryServiceBase<AnomalousEvent_WindLoadTable>();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}
