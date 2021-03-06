﻿using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.MonitoringDatasQueryService;
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
                case 7:
                    return new AlarmDatasManagementServiceBase<SafetyPreWarning_TemperatureTable>();
                case 8:
                    return new AlarmDatasManagementServiceBase<SafetyPreWarning_WindLoadTable>();

                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

