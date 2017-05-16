using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Service.MonitoringDatasQueryService;
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
                    return new MonitorDatasEigenvalueQueryServiceBase<Eigenvalue_SteelArchStrainEigenvalueTable>();
                case 2:
                    return new MonitorDatasEigenvalueQueryServiceBase<Eigenvalue_SteelLatticeStrainEigenvalueTable>();
                case 3:
                    return new MonitorDatasEigenvalueQueryServiceBase<Eigenvalue_ConcreteStrainEigenvalueTable>();
                case 4:
                    return new MonitorDatasEigenvalueQueryServiceBase<Eigenvalue_DisplacementEigenvalueTable>();
                case 5:
                    return new MonitorDatasEigenvalueQueryServiceBase<Eigenvalue_CableForceEigenvalueTable >();
                case 6:
                    return new MonitorDatasEigenvalueQueryServiceBase<Eigenvalue_HumidityEigenvalueTable>();
                case 7:
                    return new MonitorDatasEigenvalueQueryServiceBase<Eigenvalue_TemperatureEigenvalueTable>();
                case 8:
                    return new MonitorDatasEigenvalueQueryServiceBase<Eigenvalue_WindLoadEigenvalueTable>();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

