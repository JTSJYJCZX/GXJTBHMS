using GxjtBHMS.Service.MonitoringDatasOriginalValueDownLoad;
using System;

namespace GxjtBHMS.Service
{
    public class MonitoringDatasOriginalValueDownloadServiceFactory
    {
        public static MonitoringDatasOriginalvalueQueryServiceBase GetQueryServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                case 1:
                    return new SteelArchStrainOriginalValueDatasDownload();
                case 2:
                    return new SteelLatticeStrainOriginalValueDatasDownload();
                case 3:
                    return new ConcreteStrainDatasOriginalValueDownload();
                case 4:
                    return new DisplacementDatasOriginalValueDownload();
                case 5:
                    return new CableForceDatasOriginalValueDownload();
                case 6:
                    return new HumidityDatasOriginalValueDownload();
                case 7:
                    return new TemperatureDatasOriginalValueDownload();
                case 8:
                    return new WindLoadDatasOriginalValueDownload();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

