using GxjtBHMS.Service;
using System;

namespace GxjtBHMS.Service
{
    public class MonitoringDatasOriginalValueDownLoadServiceFactory
    {
        public static MonitoringDatasOriginalvalueQueryServiceBase GetQueryServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                case 1:
                    return new SteelArchStrainOriginalValueDatasDownLoad();
                //case 2:
                //    return new SteelLatticeStrainOriginalValueDatasDownLoad();
                case 3:
                    return new ConcreteStrainDatasOriginalValueDownLoad();
                //case 4:
                //    return new DisplaymentDatasOriginalValueDownLoad();
                //case 5:
                //    return new CableForceDatasOriginalValueDownLoad();
                //case 6:
                //    return new TemperatureDatasOriginalValueDownLoad();
                //case 7:
                //    return new HumidityDatasOriginalValueDownLoad();
                //case 8:
                //    return new WindLoadDatasOriginalValueDownLoad();
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}

