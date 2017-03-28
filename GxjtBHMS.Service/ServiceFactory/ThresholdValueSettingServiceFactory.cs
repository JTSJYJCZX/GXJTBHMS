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
                    return new ContainNegativeThresholdValueSettingServiceBase<SteelArchStrainThresholdValueTable>();
                case 2:
                    return new ContainNegativeThresholdValueSettingServiceBase<SteelLatticeStrainThresholdValueTable>();
                case 3:

                    return new ContainNegativeThresholdValueSettingServiceBase<ConcreteStrainThresholdValueTable>();
                case 4:
                    return new ContainNegativeThresholdValueSettingServiceBase<DisplacementThresholdValueTable>();
                case 5:
                    return new WithoutNegativeThresholdValueSettingServiceBase<CableForceThresholdValueTable>();
                case 6:
                    return new WithoutNegativeThresholdValueSettingServiceBase<HumidityThresholdValueTable>();
                case 7:
                    return new ContainNegativeThresholdValueSettingServiceBase<TemperatureThresholdValueTable>();
                case 8:
                    return new WithoutNegativeThresholdValueSettingServiceBase<WindLoadThresholdValueTable>();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }

       

    }
}

