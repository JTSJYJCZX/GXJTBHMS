using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.Implementations;
using System;

namespace GxjtBHMS.Service
{
    public class ThresholdValueSettingServiceFactory
    {
        public static dynamic GetThresholdValueServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                case 1:
                    return new ContainNegativeThresholdValueSettingServiceBase<ThresholdValue_SteelArchStrainThresholdValueTable>();
                case 2:
                    return new ContainNegativeThresholdValueSettingServiceBase<ThresholdValue_SteelLatticeStrainThresholdValueTable>();
                case 3:

                    return new ContainNegativeThresholdValueSettingServiceBase<ThresholdValue_ConcreteStrainThresholdValueTable>();
                case 4:
                    return new ContainNegativeThresholdValueSettingServiceBase<ThresholdValue_DisplacementThresholdValueTable>();
                case 5:
                    return new WithoutNegativeThresholdValueSettingServiceBase<ThresholdValue_CableForceThresholdValueTable>();
                case 6:
                    return new WithoutNegativeThresholdValueSettingServiceBase<ThresholdValue_HumidityThresholdValueTable>();
                case 7:
                    return new ContainNegativeThresholdValueSettingServiceBase<ThresholdValue_TemperatureThresholdValueTable>();
                case 8:
                    return new WithoutNegativeThresholdValueSettingServiceBase<ThresholdValue_WindLoadThresholdValueTable>();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }

       

    }
}

