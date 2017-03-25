using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Service.MonitoringDatasQueryService;
using NPOI.SS.Formula.Functions;
using System;

namespace GxjtBHMS.Service
{
    public class MonitoringDatasEigenvalueQueryServiceFactory
    {
        public static dynamic GetQueryServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                case 1:
                    return new MonitorDatasEigenvalueQueryServiceBase<SteelArchStrainEigenvalueTable>();
                case 2:
                    return new MonitorDatasEigenvalueQueryServiceBase<SteelLatticeStrainEigenvalueTable>();
                case 3:
                    return new MonitorDatasEigenvalueQueryServiceBase<ConcreteStrainEigenvalueTable>();
                case 4:
                    return new MonitorDatasEigenvalueQueryServiceBase<DisplacementEigenvalueTable>();
                case 5:
                    return new MonitorDatasEigenvalueQueryServiceBase<CableForceEigenValueTable>();
                case 6:
                    return new MonitorDatasEigenvalueQueryServiceBase<HumidityEigenvalueTable>();
                case 7:
                    return new MonitorDatasEigenvalueQueryServiceBase<TemperatureEigenvalueTable>();
                case 8:
                    return new MonitorDatasEigenvalueQueryServiceBase<WindLoadEigenvalueTable>();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

