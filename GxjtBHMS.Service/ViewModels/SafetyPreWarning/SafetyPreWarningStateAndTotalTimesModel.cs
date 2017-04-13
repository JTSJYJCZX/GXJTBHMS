namespace GxjtBHMS.Service.ViewModels.SafetyPreWarning
{
    public class SafetyPreWarningStateAndTotalTimesModel: SafetyStateModel
    {
        public int TestTypeId { get; set; }
        public int GradeId { get; set; }
        public int WarningGrade2Times { get; set; }
        public int WarningGrade3Times { get; set; }
    }
}
