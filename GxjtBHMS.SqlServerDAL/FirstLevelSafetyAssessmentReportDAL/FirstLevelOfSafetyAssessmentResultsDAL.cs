using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.IDAL.GetFirstLevelSafetyAssessmentReport;
using System;

namespace GxjtBHMS.SqlServerDAL.FirstLevelSafetyAssessmentReportDAL
{
   public class FirstLevelOfSafetyAssessmentResultsDAL : Repository<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable, int>, IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable>
    {
    }
}
