using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;
namespace GxjtBHMS.Service.Interfaces
{
    public interface IDisplacementRealTimeDatasService
    {
        IEnumerable<IncludeSectionWarningColorDataModel> GetWarningDisplacementDatasBy(IEnumerable<int> sectionIds);

        IEnumerable<int> GetSectionIdsBy(int testTypeId);
    }
}
