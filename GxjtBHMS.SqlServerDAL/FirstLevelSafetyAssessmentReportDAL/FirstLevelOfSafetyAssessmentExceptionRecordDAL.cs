using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.IDAL.GetFirstLevelSafetyAssessmentReport;
using System;

namespace GxjtBHMS.SqlServerDAL.FirstLevelSafetyAssessmentReportDAL
{
   public class FirstLevelOfSafetyAssessmentExceptionRecordDAL: Repository<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable,int>,IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable>
    {

    }
}
