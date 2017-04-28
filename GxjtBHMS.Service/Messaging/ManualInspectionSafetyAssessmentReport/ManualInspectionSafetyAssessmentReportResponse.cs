using GxjtBHMS.Models.ManualInspectionSafetyAssessmentTable;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Messaging.ManualInspectionSafetyAssessmentReport
{
    public class ManualInspectionSafetyAssessmentReportResponse : PagedResponse
    {
        public IEnumerable<ManualInspectionSafetyAssessmentReportTable> ManualInspectionSafetyAssessmentReport { get; set; }   

    }
}
