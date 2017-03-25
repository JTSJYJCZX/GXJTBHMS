using GxjtBHMS.Service.Implementations;
using GxjtBHMS.Service.Implementations.OriginalValueDownLoad;
using System;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;

namespace GxjtBHMS.Service
{
    public class MonitoringDatasOriginalValueDownloadServiceFactory
    {
        public static dynamic GetQueryServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                case 1:
                    return new MonitorDatasOringinalValueDownloadServiceBase<SteelArchStrainTable>();
                case 2:
                    return new MonitorDatasOringinalValueDownloadServiceBase<SteelLatticeStrainTable>();
                case 3:
                    return new MonitorDatasOringinalValueDownloadServiceBase<ConcreteStrainTable>();
                case 4:
                    return new MonitorDatasOringinalValueDownloadServiceBase<DisplacementTable>();
                case 5:
                    return new MonitorDatasOringinalValueDownloadServiceBase<CableForceTable>();
                case 6:
                    return new MonitorDatasOringinalValueDownloadServiceBase<HumidityTable>();
                case 7:
                    return new MonitorDatasOringinalValueDownloadServiceBase<TemperatureTable>();
                case 8:
                    return new MonitorDatasOringinalValueDownloadServiceBase<WindLoadTable>();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

