namespace GxjtBHMS.Models.FirstLevelSafetyAssessmentTable
{
    public class FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable : EntityBase<int>
    {
         //测试类型
        public string TestType { get; set; }
        //测点编号
        public string MonitoringPointsNumbers { get; set; }
        //测点位置
        public string MonitoringPointsPositions { get; set; }
        //异常次数
        public int ExceptionNumber { get; set; }
        //报告编号外键
        public virtual FirstAssessment_FirstLevelSafetyAssessmentReportTable AssessmentReport { get; set; }
        public int AssessmentReportId { get; set; }
    }
}
