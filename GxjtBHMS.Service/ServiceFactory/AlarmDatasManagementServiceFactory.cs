using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.MonitoringDatasQueryService;
using NPOI.SS.Formula.Functions;
using System;

namespace GxjtBHMS.Service
{
    public class AlarmDatasManagementServiceFactory
    {
        public static dynamic GetQueryServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                case 4:
                    return new AlarmDatasManagementServiceBase<SafetyPreWarning_DisplacementTable>();
                case 5:
                    return new AlarmDatasManagementServiceBase<SafetyPreWarning_CableForceTable>();
                case 6:
                    return new AlarmDatasManagementServiceBase<SafetyPreWarning_WindLoadTable>();
                case 7:
                    return new AlarmDatasManagementServiceBase<SafetyPreWarning_TemperatureTable>();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

