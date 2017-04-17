using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Models;
using GxjtBHMS.Models.AbnormalThresholdValueSetting;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Models.MonitoringDatasTable;
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

        public DbSet<Basic_SteelArchStrainTable > SteelArchStrains { get; set; }//钢拱肋应变
        public DbSet<Basic_SteelLatticeStrainTable > SteelLatticeStrains { get; set; }//钢格构应变
        public DbSet<Basic_ConcreteStrainTable > ConcreteStrains { get; set; }//混凝土应变
        public DbSet<Basic_DisplacementTable> Displacements { get; set; }//位移
        public DbSet<Basic_CableForceTable> CableForces { get; set; }//索力
        public DbSet<Basic_TemperatureTable> Temperatures { get; set; }//温度 
        public DbSet<Basic_HumidityTable> Humiditys { get; set; }//湿度 
        public DbSet<Basic_WindLoadTable > WindLoads { get; set; }//风载

        public DbSet<SteelArchStrainEigenvalueTable> SteelArchStrainEigenvalues { get; set; }//钢拱肋应变特征值
        public DbSet<SteelLatticeStrainEigenvalueTable> SteelLatticeStrainEigenvalues { get; set; }//钢格构应变特征值
        public DbSet<ConcreteStrainEigenvalueTable> ConcreteStrainEigenvalues { get; set; }//混凝土应变特征值
        public DbSet<DisplacementEigenvalueTable> DisplacementEigenvalues { get; set; }//位移特征值
        public DbSet<CableForceEigenValueTable> CableForceEigenvalues { get; set; }//索力特征值
        public DbSet<TemperatureEigenvalueTable> TemperatureEigenvalues { get; set; }//温度特征值
        public DbSet<HumidityEigenvalueTable> HumidityEigenvalues { get; set; }//湿度特征值
        public DbSet<WindLoadEigenvalueTable> WindLoadEigenvalues { get; set; }//风载特征值

        public DbSet<ThresholdValue_ConcreteStrainThresholdValueTable> ConcreteStrainThresholdValues { get; set; }//混凝土应变阈值
        public DbSet<ThresholdValue_SteelArchStrainThresholdValueTable> SteelArchStrainThresholdValues { get; set; }//钢拱肋应变阈值
        public DbSet<ThresholdValue_SteelLatticeStrainThresholdValueTable> SteelLatticeStrainThresholdValues { get; set; }//拱格构应变阈值
        public DbSet<ThresholdValue_DisplacementThresholdValueTable> DisplaymentThresholdValues { get; set; }//位移阈值
        public DbSet<ThresholdValue_CableForceThresholdValueTable> CableForceThresholdValues { get; set; }//索力阈值
        public DbSet<ThresholdValue_TemperatureThresholdValueTable> TemperatureThresholdValues { get; set; }//温度阈值
        public DbSet<ThresholdValue_HumidityThresholdValueTable> HumidityThresholdValues { get; set; }//湿度阈值
        public DbSet<ThresholdValue_WindLoadThresholdValueTable> WindLoadThresholdValues { get; set; }//风荷载阈值

        public DbSet<AbnormalThresholdValueTable> AbnormalThresholdValue { get; set; }//异常阈值
        public DbSet<ThresholdGradeTable> ThresholdGradeModel { get; set; }//预警等级

        //安全预警值统计结果表格
        public DbSet<SafetyPreWarning_CableForceTable> SafetyPreWarning_CableFrces { get; set; }//索力安全预警值
        public DbSet<SafetyPreWarning_DisplacementTable> SafetyPreWarning_Displacements { get; set; }//位移安全预警值
        public DbSet<SafetyPreWarning_TemperatureTable> SafetyPreWarning_Temperatures { get; set; }//位移安全预警值
        public DbSet<SafetyPreWarning_WindLoadTable> SafetyPreWarning_WindLoads { get; set; }//位移安全预警值



    }
}
