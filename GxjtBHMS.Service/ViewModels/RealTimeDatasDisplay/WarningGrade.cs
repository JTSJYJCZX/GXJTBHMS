using System.ComponentModel;

namespace GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay
{
    public enum WarningGrade
    {
        [Description("forestgreen")]
        Health,
        [Description("gold")]
        FirstWarning,
        [Description("orangered")]
        SecondWarning,
        [Description("red")]
        Danger,
    }
}
