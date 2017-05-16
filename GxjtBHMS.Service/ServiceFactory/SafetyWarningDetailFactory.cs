using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.SafetyPreWarningQueryService;
using System;

namespace GxjtBHMS.Service.ServiceFactory
{
    public class SafetyWarningDetailFactory
    {
        public static dynamic GetSafetyWarningDetailServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                case 1:
                    return new SafetyPreWarningQueryServiceBase<SafetyPreWarning_WindLoadTable>();
                case 2:
                    return new SafetyPreWarningQueryServiceBase<SafetyPreWarning_TemperatureTable>();
                case 3:
                    return new SafetyPreWarningQueryServiceBase<SafetyPreWarning_CableForceTable>();
                case 4:
                    return new SafetyPreWarningQueryServiceBase<SafetyPreWarning_DisplacementTable>();

                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}
