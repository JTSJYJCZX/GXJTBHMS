using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Models;
using GxjtBHMS.Models.AbnormalThresholdValueSetting;
using GxjtBHMS.Models.AnomalousEventTable;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.Models.ManualInspectionSafetyAssessmentTable;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Models.SecondLevelSafetyAssessmentTable;
using GxjtBHMS.Models.SpecialSafetyAssessmentReportTable;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Data.Entity;

namespace GxjtBHMS.SqlServerDAL
{
    public class BHMSContext : DbContext
    {
        static readonly string ConnectionName;

        public BHMSContext() : base(ConnectionName) { }
        static BHMSContext()
        {
            ConnectionName = ApplicationSettingsFactory.GetApplicationSettings().DBConnectionName;
            Database.SetInitializer(new AppDbInitializer());
        }
        public DbSet<User> Users { get; set; }
        public DbSet<UserState> UserStates { get; set; }
        public DbSet<MonitoringTestType> MonitoringTestTypes { get; set; }
        public DbSet<MonitoringPointsPosition> MonitoringPointsPositions { get; set; }
        public DbSet<MonitoringPointsNumber> MonitoringPointsNumbers { get; set; }

        /// <summary>
        /// 原始数据表
        /// </summary>
        public DbSet<Original_SteelArchStrainTable> Original_SteelArchStrains { get; set; }//钢拱肋应变
        public DbSet<Original_SteelLatticeStrainTable> Original_SteelLatticeStrains { get; set; }//钢格构应变
        public DbSet<Original_ConcreteStrainTable> Original_ConcreteStrains { get; set; }//混凝土应变
        public DbSet<Original_DisplacementTable> Original_Displacements { get; set; }//位移
        public DbSet<Original_CableForceTable> Original_CableForces { get; set; }//索力
        public DbSet<Original_TemperatureTable> Original_Temperatures { get; set; }//温度 
        public DbSet<Original_HumidityTable> Original_Humiditys { get; set; }//湿度 
        public DbSet<Original_WindLoadTable> Original_WindLoads { get; set; }//风载

        /// <summary>
        /// 基础数据表
        /// </summary>
        public DbSet<Basic_SteelArchStrainTable > Basic_SteelArchStrains { get; set; }//钢拱肋应变
        public DbSet<Basic_SteelLatticeStrainTable > Basic_SteelLatticeStrains { get; set; }//钢格构应变
        public DbSet<Basic_ConcreteStrainTable > Basic_ConcreteStrains { get; set; }//混凝土应变
        public DbSet<Basic_DisplacementTable> Basic_Displacements { get; set; }//位移
        public DbSet<Basic_CableForceTable> Basic_CableForces { get; set; }//索力
        public DbSet<Basic_TemperatureTable> Basic_Temperatures { get; set; }//温度 
        public DbSet<Basic_HumidityTable> Basic_Humiditys { get; set; }//湿度 
        public DbSet<Basic_WindLoadTable > Basic_WindLoads{ get; set; }//风载

        public DbSet<Eigenvalue_SteelArchStrainEigenvalueTable> SteelArchStrainEigenvalues { get; set; }//钢拱肋应变特征值
        public DbSet<Eigenvalue_SteelLatticeStrainEigenvalueTable> SteelLatticeStrainEigenvalues { get; set; }//钢格构应变特征值
        public DbSet<Eigenvalue_ConcreteStrainEigenvalueTable> ConcreteStrainEigenvalues { get; set; }//混凝土应变特征值
        public DbSet<Eigenvalue_DisplacementEigenvalueTable> DisplacementEigenvalues { get; set; }//位移特征值
        public DbSet<Eigenvalue_CableForceEigenvalueTable > CableForceEigenvalues { get; set; }//索力特征值
        public DbSet<Eigenvalue_TemperatureEigenvalueTable> TemperatureEigenvalues { get; set; }//温度特征值
        public DbSet<Eigenvalue_HumidityEigenvalueTable> HumidityEigenvalues { get; set; }//湿度特征值
        public DbSet<Eigenvalue_WindLoadEigenvalueTable> WindLoadEigenvalues { get; set; }//风载特征值

        public DbSet<ThresholdValue_ConcreteStrainThresholdValueTable> ConcreteStrainThresholdValues { get; set; }//混凝土应变阈值
        public DbSet<ThresholdValue_SteelArchStrainThresholdValueTable> SteelArchStrainThresholdValues { get; set; }//钢拱肋应变阈值
        public DbSet<ThresholdValue_SteelLatticeStrainThresholdValueTable> SteelLatticeStrainThresholdValues { get; set; }//拱格构应变阈值
        public DbSet<ThresholdValue_DisplacementThresholdValueTable> DisplaymentThresholdValues { get; set; }//位移阈值
        public DbSet<ThresholdValue_CableForceThresholdValueTable> CableForceThresholdValues { get; set; }//索力阈值
        public DbSet<ThresholdValue_TemperatureThresholdValueTable> TemperatureThresholdValues { get; set; }//温度阈值
        public DbSet<ThresholdValue_HumidityThresholdValueTable> HumidityThresholdValues { get; set; }//湿度阈值
        public DbSet<ThresholdValue_WindLoadThresholdValueTable> WindLoadThresholdValues { get; set; }//风荷载阈值

        public DbSet<Abnormal_ThresholdValueTable> AbnormalThresholdValue { get; set; }//异常阈值
        public DbSet<ThresholdGradeTable> ThresholdGradeModel { get; set; }//预警等级

        //安全预警值统计结果表格
        public DbSet<SafetyPreWarning_CableForceTable> SafetyPreWarning_CableFrces { get; set; }//索力安全预警值
        public DbSet<SafetyPreWarning_DisplacementTable> SafetyPreWarning_Displacements { get; set; }//位移安全预警值
        public DbSet<SafetyPreWarning_TemperatureTable> SafetyPreWarning_Temperatures { get; set; }//位移安全预警值
        public DbSet<SafetyPreWarning_WindLoadTable> SafetyPreWarning_WindLoads { get; set; }//位移安全预警值
        public DbSet<SafetyPreWarning_StrainTable> SafetyPreWarning_Strains { get; set; }//应变安全预警值

        //一级安全评估报告
        public DbSet<FirstAssessment_FirstLevelSafetyAssessmentReportTable> FirstLevelSafetyAssessmentReports { get; set; }
        public DbSet<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable> FirstLevelOfSafetyAssessmentResults { get; set; }
        public DbSet<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable> FirstLevelOfSafetyAssessmentExceptionRecords { get; set; }
        public DbSet<FirstAssessment_FirstLevelSafetyAssessmentReasonsTable> FirstLevelSafetyAssessmentReasons { get; set; }

        public DbSet<SecondAssessment_SecondLevelSafetyAssessmentReportTable> SecondAssessment_SecondLevelSafetyAssessmentReports { get; set; }
        public DbSet<SecondAssessment_SecondLevelSafetyAssessmentStateTable> SecondAssessment_SecondLevelSafetyAssessmentStates { get; set; }

        //人工巡检报告
        public DbSet<ManualInspectionSafetyAssessmentReportTable> ManualInspectionSafetyAssessmentReports { get; set; }
        public DbSet<ManualInspectionSafetyAssessmentStateTable> ManualInspectionSafetyAssessmentStates { get; set; }

        //专项评估报告
        public DbSet<SpecialAssessment_SpecialSafetyAssessmentReportTable> SpecialAssessment_SpecialSafetyAssessmentReportStates { get; set; }

        //异常事件
        public DbSet<AnomalousEvent_SteelArchStrainTable> AnomalousEvent_SteelArchStrains { get; set; }//钢拱肋应变
        public DbSet<AnomalousEvent_SteelLatticeStrainTable> AnomalousEvent_SteelLatticeStrains { get; set; }//钢格构应变
        public DbSet<AnomalousEvent_ConcreteStrainTable> AnomalousEvent_ConcreteStrains { get; set; }//混凝土应变
        public DbSet<AnomalousEvent_DisplacementTable> AnomalousEvent_Displacements { get; set; }//位移
        public DbSet<AnomalousEvent_CableForceTable> AnomalousEvent_CableForces { get; set; }//索力
        public DbSet<AnomalousEvent_TemperatureTable> AnomalousEvent_Temperatures { get; set; }//温度 
        public DbSet<AnomalousEvent_HumidityTable> AnomalousEvent_Humiditys { get; set; }//湿度 
        public DbSet<AnomalousEvent_WindLoadTable> AnomalousEvent_WindLoads { get; set; }//风载
        public DbSet<AnomalousEventReasonTable> AnomalousEventReasons { get; set; }//异常事件原因
    }
}
