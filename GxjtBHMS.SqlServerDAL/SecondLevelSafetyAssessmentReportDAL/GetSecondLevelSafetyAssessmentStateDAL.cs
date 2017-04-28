using GxjtBHMS.IDAL;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;
using GxjtBHMS.SqlServerDAL.SecondLevelSafetyAssessmentReportDAL;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.SecondLevelSafetyAssessmentReportDAL
{
    public class GetSecondLevelSafetyAssessmentStateDAL : Repository<SecondAssessment_SecondLevelSafetyAssessmentStateTable, int>, IGetSecondLevelSafetyAssessmentStateDAL
    {
    }
}
