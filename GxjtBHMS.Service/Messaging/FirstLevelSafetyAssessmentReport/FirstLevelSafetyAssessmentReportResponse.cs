using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class FirstLevelSafetyAssessmentReportResponse : PagedResponse
    {
        public IEnumerable<FirstLevelSafetyAssessmentReportTable> FirstLevelSafetyAssessmentReport { get; set; }   

    }
}
