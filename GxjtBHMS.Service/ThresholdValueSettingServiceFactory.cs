﻿using GxjtBHMS.Service.Implementations;
using System;

namespace GxjtBHMS.Service
{
    public class ThresholdValueSettingServiceFactory
    {
        public static ThresholdValueSettingServiceBase GetThresholdValueServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                //case 1:
                //    return new SteelArchStrainEigenvalueDatasQuery();
                //case 2:
                //    return new SteelLatticeStrainEigenvalueDatasQuery();
                case 3:
                    return new ConcreteStrainThresholdValueSettingService();
                //case 4:
                //    return new DisplacementEigenvalueDatasQuery();
                //case 5:
                //    return new CableForceEigenvalueDatasQuery();
                //case 6:
                //    return new HumidityEigenvalueDatasQuery();
                //case 7:
                //    return new TemperatureEigenvalueDatasQuery();
                //case 8:
                //    return new WindLoadEigenvalueDatasQuery();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

