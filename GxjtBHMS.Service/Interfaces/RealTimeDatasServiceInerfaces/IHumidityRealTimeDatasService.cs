using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;
namespace GxjtBHMS.Service.Interfaces
{
    public interface IHumidityRealTimeDatasService
    {
        IEnumerable<IncludeSectionWarningColorDataModel> GetWarningHumidityDatasBy(IEnumerable<int> sectionIds);

        IEnumerable<int> GetSectionIdsBy(int testTypeId);
    }
}
