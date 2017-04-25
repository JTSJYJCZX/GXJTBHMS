using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging
{
    public class SecondLevelSafetyAssessmentReportResponse : PagedResponse
    {
        public IEnumerable<SecondAssessment_SecondLevelSafetyAssessmentReportTable> SecondLevelSafetyAssessmentReport { get; set; }   

    }
}
