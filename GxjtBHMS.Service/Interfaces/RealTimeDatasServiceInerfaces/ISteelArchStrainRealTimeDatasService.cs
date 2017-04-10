using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;
namespace GxjtBHMS.Service.Interfaces
{
    public interface ISteelArchStrainRealTimeDatasService
    {
        IEnumerable<IncludeSectionWarningColorDataModel> GetWarningStrainDatasBy(IEnumerable<int> sectionIds);
        IEnumerable<int> GetSectionIdsBy(int testTypeId);
    }
}
