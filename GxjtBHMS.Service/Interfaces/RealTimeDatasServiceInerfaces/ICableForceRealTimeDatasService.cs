using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;
namespace GxjtBHMS.Service.Interfaces
{
    public interface ICableForceRealTimeDatasService
    {
        IEnumerable<IncludeSectionWarningColorDataModel> GetWarningCableForceDatasBy(IEnumerable<int> sectionIds);

        IEnumerable<int> GetSectionIdsBy(int testTypeId);
    }
}
