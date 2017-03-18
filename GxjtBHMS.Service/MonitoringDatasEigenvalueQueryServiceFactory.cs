using System;

namespace GxjtBHMS.Service
{
    public class MonitoringDatasEigenvalueQueryServiceFactory
    {
        public static MonitoringDatasEigenvalueQueryServiceBase GetQueryServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                case 1:
                    return new SteelArchStrainEigenvalueDatasQuery();
                case 2:
                    return new SteelLatticeStrainEigenvalueDatasQuery();
                case 3:
                    return new ConcreteStrainEigenvalueDatasQuery();
                case 4:
                    return new DisplaymentEigenvalueDatasQuery();
                case 5:
                    return new CableForceEigenvalueDatasQuery();
                case 6:
                    return new TemperatureEigenvalueDatasQuery();
                case 7:
                    return new HumidityEigenvalueDatasQuery();
                case 8:
                    return new WindLoadEigenvalueDatasQuery();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

