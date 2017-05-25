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
        public const string SafetyPreWarningThresholdGrade1Color = "darkgreen";
        public const string SafetyPreWarningThresholdGrade2Color = "#FFD306";
        public const string SafetyPreWarningThresholdGrade3Color = "Red";

        //下载的存储过程名称
        public const string SteelArchStrainDatasEigenvalueDownloadProc = "usp_EigenvalueSteelArchStrainSaveAsTxt";
        public const string SteelLatticeStrainDatasEigenvalueDownloadProc = "usp_EigenvalueSteelLatticeStrainSaveAsTxt";
        public const string ConcreteStrainDatasEigenvalueDownloadProc = "usp_EigenvalueConcreteStrainSaveAsTxt";
        public const string CableForceDatasEigenvalueDownloadProc = "usp_EigenvalueCableForceSaveAsTxt";
        public const string DisplacementDatasEigenvalueDownloadProc = "usp_EigenvalueDisplacementSaveAsTxt";
        public const string HumidityDatasEigenvalueDownloadProc = "usp_EigenvalueHumiditySaveAsTxt";
        public const string TemperatureDatasEigenvalueDownloadProc = "usp_EigenvalueTemperatureSaveAsTxt";
        public const string WindLoadDatasEigenvalueDownloadProc = "usp_EigenvalueWindLoadSaveAsTxt";

    }
}
