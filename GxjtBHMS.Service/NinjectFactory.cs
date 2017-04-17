﻿using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.Implementations;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.SqlServerDAL;
using Ninject;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Implementations.OriginalValueDownLoad;
using GxjtBHMS.IDAL.OriginalValueDownLoad;
using GxjtBHMS.SqlServerDAL.MonitoringDatasDAL;
using GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.Interfaces.MonitoringDatasQueryServiceInerfaces;
using GxjtBHMS.SqlServerDAL.AbnormalThresholdValueSettingDAL;
using GxjtBHMS.SqlServerDAL.SafetyPreWarningDAL;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningQueryServiceInerfaces;
using GxjtBHMS.IDAL.SafetyPreWarning;
using GxjtBHMS.SqlServerDAL.SafetyPreWarningRealTimePushDAL;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using NPOI.SS.Formula.Functions;
using GxjtBHMS.Service.SafetyPreWarningRealTimeHubService;
using GxjtBHMS.Models.SafetyPreWarningTable;

namespace GxjtBHMS.Service
{
    public class NinjectFactory
    {
        IKernel _ninjectKernel;
        public NinjectFactory()
        {
            _ninjectKernel = new StandardKernel();
            AddBinding();
        }
        public T GetInstance<T>()
        {
            return _ninjectKernel.Get<T>();
        }
        void AddBinding()
        {
            
            _ninjectKernel.Bind<IMonitoringPointsNumberDAL>().To<MonitoringPointsNumberDAL>();
            _ninjectKernel.Bind<IMonitoringPointsPositionDAL>().To<MonitoringPointsPositionDAL>();

            _ninjectKernel.Bind<IConcreteStrainDatasOriginalValueDAL>().To<ConcreteStrainDatasOriginalValueDAL>();
            _ninjectKernel.Bind<ISteelArchStrainDatasOriginalValueDAL>().To<SteelArchStrainDatasOriginalValueDAL>();
            _ninjectKernel.Bind<ISteelLatticeStrainDatasOriginalValueDAL>().To<SteelLatticeStrainDatasOriginalValueDAL>();
            _ninjectKernel.Bind<IDisplacementDatasOriginalValueDAL>().To<DisplacementDatasOriginalValueDAL>();
            _ninjectKernel.Bind<ICableForceDatasOriginalValueDAL>().To<CableForceDatasOriginalValueDAL>();
            _ninjectKernel.Bind<ITemperatureDatasOriginalValueDAL>().To<TemperatureDatasOriginalValueDAL>();
            _ninjectKernel.Bind<IHumidityDatasOriginalValueDAL>().To<HumidityDatasOriginalValueDAL>();
            _ninjectKernel.Bind<IWindLoadDatasOriginalValueDAL>().To<WindLoadDatasOriginalValueDAL>();

            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<ConcreteStrainEigenvalueTable>>().To<ConcreteStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<SteelArchStrainEigenvalueTable>>().To<SteelArchStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<SteelLatticeStrainEigenvalueTable>>().To<SteelLatticeStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<DisplacementEigenvalueTable>>().To<DisplaymentDatasEigenValueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<CableForceEigenValueTable>>().To<CableForceDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<HumidityEigenvalueTable>>().To<HumidityDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<TemperatureEigenvalueTable>>().To<TemperatureDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<WindLoadEigenvalueTable>>().To<WindLoadDatasEigenvalueDAL>();



            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<ConcreteStrainEigenvalueTable>>().To<MonitorDatasQueryChartService<ConcreteStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<SteelArchStrainEigenvalueTable>>().To<MonitorDatasQueryChartService<SteelArchStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<SteelLatticeStrainEigenvalueTable>>().To<MonitorDatasQueryChartService<SteelLatticeStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<DisplacementEigenvalueTable>>().To<MonitorDatasQueryChartService<DisplacementEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<CableForceEigenValueTable>>().To<MonitorDatasQueryChartService<CableForceEigenValueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<HumidityEigenvalueTable>>().To<MonitorDatasQueryChartService<HumidityEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<TemperatureEigenvalueTable>>().To<MonitorDatasQueryChartService<TemperatureEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<WindLoadEigenvalueTable>>().To<MonitorDatasQueryChartService<WindLoadEigenvalueTable>>();

            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<Basic_SteelArchStrainTable >>().To<SteelArchStrainMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<Basic_ConcreteStrainTable >>().To<ConcreteStrainMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<Basic_SteelLatticeStrainTable >>().To<SteelLatticeStrainMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<Basic_DisplacementTable>>().To<DisplacementMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<Basic_CableForceTable>>().To<CableForceMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<Basic_TemperatureTable>>().To<TemperatureDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<Basic_HumidityTable>>().To<HumidityDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<Basic_WindLoadTable >>().To<WindLoadDatasOriginalValueDownloadFileSystemService>();



            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<ConcreteStrainEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<ConcreteStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelArchStrainEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<SteelArchStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelLatticeStrainEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<SteelLatticeStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<DisplacementEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<DisplacementEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<CableForceEigenValueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<CableForceEigenValueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<HumidityEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<HumidityEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<TemperatureEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<TemperatureEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<WindLoadEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<WindLoadEigenvalueTable>>();

            _ninjectKernel.Bind<IThresholdValueSettingDAL<ThresholdValue_SteelArchStrainThresholdValueTable>>().To<SteelArchStrainThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<ThresholdValue_SteelLatticeStrainThresholdValueTable>>().To<SteelLatticeStrainThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<ThresholdValue_WindLoadThresholdValueTable>>().To<WindLoadThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<ThresholdValue_ConcreteStrainThresholdValueTable>>().To<ConcreteStrainThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<ThresholdValue_DisplacementThresholdValueTable>>().To<DisplacementThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<ThresholdValue_CableForceThresholdValueTable>>().To<CableForceThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<ThresholdValue_HumidityThresholdValueTable>>().To<HumidityThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<ThresholdValue_TemperatureThresholdValueTable>>().To<TemperatureThresholdValueSettingDAL>();

            _ninjectKernel.Bind<IAbnormalThresholdValueSettingDAL>().To<AbnormalThresholdValueSettingDAL>();

            _ninjectKernel.Bind<ISafetyPreWarningDetailDAL<SafetyPreWarning_CableForceTable>>().To<SafetyPreWarning_CableFrceTableDAL>();
            _ninjectKernel.Bind<ISafetyPreWarningDetailDAL<SafetyPreWarning_DisplacementTable>>().To<SafetyPreWarning_DisplacementTableDAL>();
            _ninjectKernel.Bind<ISafetyPreWarningDetailDAL<SafetyPreWarning_TemperatureTable>>().To<SafetyPreWarning_TemperatureTableDAL>();
            _ninjectKernel.Bind<ISafetyPreWarningDetailDAL<SafetyPreWarning_WindLoadTable>>().To<SafetyPreWarning_WindLoadTableDAL>();

  //安全预警Hub推送DAL注入
_ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_CableForceTable>>().To<CableForce_SafetyPreWarningRealTimePushDAL>();
_ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_DisplacementTable>>().To<Displacement_SafetyPreWarningRealTimePushDAL>();
_ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_WindLoadTable>>().To<WindLoad_SafetyPreWarningRealTimePushDAL>();
_ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_TemperatureTable>>().To<Temperature_SafetyPreWarningRealTimePushDAL>();

        }
    }
}
