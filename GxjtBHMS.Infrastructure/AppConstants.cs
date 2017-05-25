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

        //存储过程名称
        public const string BasicSteelArchStrain_Procedure = "usp_BasicSteelArchStrainSaveAsTxt";
        public const string BasicCableForce_Procedure = "usp_Basic_CableForceSaveAsTxt";
        public const string BasicConcreteStrain_Procedure = "usp_BasicConcreteStrainSaveAsTxt";
        public const string BasicDisplacement_Procedure = "usp_BasicDisplacementSaveAsTxt";
        public const string BasicHumidity_Procedure = "usp_BasicHumiditySaveAsTxt";
        public const string BasicSteelLatticeStrain_Procedure = "usp_BasicSteelLatticeStrainSaveAsTxt";
        public const string BasicTemperature_Procedure = "usp_BasicTemperatureSaveAsTxt";
        public const string BasicWindLoad_Procedure = "usp_BasicWindLoadSaveAsTxt";

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
