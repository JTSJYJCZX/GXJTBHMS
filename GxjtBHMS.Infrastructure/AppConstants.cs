namespace GxjtBHMS.Infrastructure
{
    public static class AppConstants
    {
        public const string DefaultPlainTextPassword = "123456";
        public const string LoginIdPrefix = "user";
        public const string NormalState = "启用";
        public const string UnNormalState = "挂起";
        public const string NormalStateDescription = "表示账号状态正常";
        public const string UnNormalStateDescription = "表示账号停用";
        public const string LoginIdFormat = "000";

        //预警颜色
        public const string SafetyPreWarningThresholdGrade1Color = "LawnGreen";
        public const string SafetyPreWarningThresholdGrade2Color = "Gold";
        public const string SafetyPreWarningThresholdGrade3Color = "Red";
    }
}
