﻿using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Models;
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

        public DbSet<SteelArchStrainTable> SteelArchStrains { get; set; }//钢拱肋应变
        public DbSet<SteelLatticeStrainTable> SteelLatticeStrains { get; set; }//钢格构应变
        public DbSet<ConcreteStrainTable> ConcreteStrains { get; set; }//混凝土应变
        public DbSet<DisplacementTable> Displacements { get; set; }//位移
        public DbSet<CableForceTable> CableForces { get; set; }//索力
        public DbSet<TemperatureTable> Temperatures { get; set; }//温度 
        public DbSet<HumidityTable> Humiditys { get; set; }//湿度 
        public DbSet<WindLoadTable> WindLoads { get; set; }//风载

        public DbSet<SteelArchStrainEigenvalueTable> SteelArchStrainEigenvalues { get; set; }//钢拱肋应变特征值
        public DbSet<SteelLatticeStrainEigenvalueTable> SteelLatticeStrainEigenvalues { get; set; }//钢格构应变特征值
        public DbSet<ConcreteStrainEigenvalueTable> ConcreteStrainEigenvalues { get; set; }//混凝土应变特征值
        public DbSet<DisplacementEigenvalueTable> DisplacementEigenvalues { get; set; }//位移特征值
        public DbSet<CableForceEigenvalueTable> CableForceEigenvalues { get; set; }//索力特征值
        public DbSet<TemperatureEigenvalueTable> TemperatureEigenvalues { get; set; }//温度特征值
        public DbSet<HumidityEigenvalueTable> HumidityEigenvalues { get; set; }//湿度特征值
        public DbSet<WindLoadEigenvalueTable> WindLoadEigenvalues { get; set; }//风载特征值

        public DbSet<StrainThresholdValueTable> StrainThresholdValues { get; set; }//应变阈值
        public DbSet<DisplaymentThresholdValueTable> DisplaymentThresholdValues { get; set; }//位移阈值
        public DbSet<CableForceThresholdValueTable> CableForceThresholdValues { get; set; }//索力阈值
        public DbSet<TemperatureThresholdValueTable> TemperatureThresholdValues { get; set; }//温度阈值
        public DbSet<HumidityThresholdValueTable> HumidityThresholdValues { get; set; }//湿度阈值
    }
}