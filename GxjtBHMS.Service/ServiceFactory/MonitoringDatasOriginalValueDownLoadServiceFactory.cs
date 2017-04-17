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
                    return new MonitorDatasOringinalValueDownloadServiceBase<Basic_SteelArchStrainTable >();
                case 2:
                    return new MonitorDatasOringinalValueDownloadServiceBase<Basic_SteelLatticeStrainTable >();
                case 3:
                    return new MonitorDatasOringinalValueDownloadServiceBase<Basic_ConcreteStrainTable >();
                case 4:
                    return new MonitorDatasOringinalValueDownloadServiceBase<Basic_DisplacementTable>();
                case 5:
                    return new MonitorDatasOringinalValueDownloadServiceBase<Basic_CableForceTable>();
                case 6:
                    return new MonitorDatasOringinalValueDownloadServiceBase<Basic_HumidityTable>();
                case 7:
                    return new MonitorDatasOringinalValueDownloadServiceBase<Basic_TemperatureTable>();
                case 8:
                    return new MonitorDatasOringinalValueDownloadServiceBase<Basic_WindLoadTable >();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

