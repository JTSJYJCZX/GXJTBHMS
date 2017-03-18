using System.Collections.Generic;

namespace GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay
{
    public class IncludeSectionWarningColorDataModel
    {
        public WarningGrade SectionWarningGrade { get; set; }
        public string SectionWarningColor { get; set; }
        public IEnumerable<RealTimeWarningDataModel> WarningRealTimeData { get; set; }

    }
}
