using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ManualInspectionSafetyAssessmentTable;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;
using GxjtBHMS.SqlServerDAL.SecondLevelSafetyAssessmentReportDAL;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.ManualInspectionSafetyAssessmentReportDAL
{
    public class GetManualInspectionSafetyAssessmentStateDAL : Repository<ManualInspectionSafetyAssessmentStateTable, int>, IGetManualInspectionSafetyAssessmentStateDAL
    {
    }
}
