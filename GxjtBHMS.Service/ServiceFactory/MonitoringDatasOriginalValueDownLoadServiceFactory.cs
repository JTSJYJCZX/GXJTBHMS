using GxjtBHMS.Service.Implementations;
using GxjtBHMS.Service.Implementations.OriginalValueDownLoad;
using System;

namespace GxjtBHMS.Service
{
    public class MonitoringDatasOriginalValueDownloadServiceFactory
    {
        public static MonitoringDatasOriValueServiceBase GetQueryServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                case 1:
                    return new SteelArchStrainDatasOriginalValueDownloadService();
                case 2:
                    return new SteelLatticeStrainDatasOriginalValueDownloadService();
                case 3:
                    return new ConcreteStrainDatasOriginalValueDownloadService();
                case 4:
                    return new DisplacementDatasOriginalValueDownloadService();
                case 5:
                    return new CableForceDatasOriginalValueDownloadService();
                case 6:
                    return new HumidityDatasOriginalValueDownloadService();
                case 7:
                    return new TemperatureDatasOriginalValueDownloadService();
                case 8:
                    return new WindLoadDatasOriginalValueDownloadService();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

