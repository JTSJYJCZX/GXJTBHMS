using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.SafetyPreWarningQueryService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Service.ServiceFactory
{
   public class SafetyWarningDetailFactory
    {
        public static dynamic GetSafetyWarningDetailServiceFrom(int mornitoringTestTypeId)
        {
            switch (mornitoringTestTypeId)
            {
                //case 1:
                //    return new MonitorDatasEigenvalueQueryServiceBase<SteelArchStrainEigenvalueTable>();
                //case 2:
                //    return new MonitorDatasEigenvalueQueryServiceBase<SteelLatticeStrainEigenvalueTable>();
                case 3:
                    return new SafetyPreWarningQueryServiceBase<SafetyPreWarning_CableFrceTable>();                      
                //case 4:
                //    return new MonitorDatasEigenvalueQueryServiceBase<DisplacementEigenvalueTable>();
               
                default:
                    throw new ApplicationException("No TestTypeId");
            }

        }
    }
}
