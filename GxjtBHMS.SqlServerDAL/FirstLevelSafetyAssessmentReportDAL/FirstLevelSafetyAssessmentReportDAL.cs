using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.IDAL.GetFirstLevelSafetyAssessmentReport;
using System;

namespace GxjtBHMS.SqlServerDAL.FirstLevelSafetyAssessmentReportDAL
{
   public class FirstLevelSafetyAssessmentReportDAL : Repository<FirstAssessment_FirstLevelSafetyAssessmentReportTable, int>, IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelSafetyAssessmentReportTable>
    {
    }
}
