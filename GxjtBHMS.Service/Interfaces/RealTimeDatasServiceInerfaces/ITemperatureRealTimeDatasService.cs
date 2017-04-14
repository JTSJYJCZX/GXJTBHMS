using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;
namespace GxjtBHMS.Service.Interfaces
{
    public interface ITemperatureRealTimeDatasService
    {
        IEnumerable<IncludeSectionWarningColorDataModel> GetWarningTemperatureDatasBy(IEnumerable<int> sectionIds);

        IEnumerable<int> GetSectionIdsBy(int testTypeId);
    }
}
