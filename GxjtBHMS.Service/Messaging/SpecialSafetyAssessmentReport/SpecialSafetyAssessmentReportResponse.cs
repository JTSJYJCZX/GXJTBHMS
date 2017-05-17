using GxjtBHMS.Models.SpecialSafetyAssessmentReportTable;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class SpecialSafetyAssessmentReportResponse : PagedResponse
    {
        public IEnumerable<SpecialAssessment_SpecialSafetyAssessmentReportTable> SecondLevelSafetyAssessmentReport { get; set; }   

    }
}
