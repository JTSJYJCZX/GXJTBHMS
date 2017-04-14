using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;
namespace GxjtBHMS.Service.Interfaces
{
    public interface IWindLoadRealTimeDatasService
    {
        IEnumerable<IncludeSectionWarningColorDataModel> GetWarningWindLoadDatasBy(IEnumerable<int> sectionIds);

        IEnumerable<int> GetSectionIdsBy(int testTypeId);
    }
}
