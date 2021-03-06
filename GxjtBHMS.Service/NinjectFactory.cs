﻿using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.Implementations;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.SqlServerDAL;
using Ninject;
using GxjtBHMS.IDAL.OriginalValueDownLoad;
using GxjtBHMS.SqlServerDAL.MonitoringDatasDAL;
using GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.Interfaces.MonitoringDatasQueryServiceInerfaces;
using GxjtBHMS.SqlServerDAL.AbnormalThresholdValueSettingDAL;
using GxjtBHMS.SqlServerDAL.SafetyPreWarningDAL;
using GxjtBHMS.SqlServerDAL.FirstLevelSafetyAssessmentReportDAL;
using GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces;
using GxjtBHMS.Service.Implementations.AlarmDatasManagement;
using GxjtBHMS.SqlServerDAL.SecondLevelSafetyAssessmentReportDAL;
using GxjtBHMS.SqlServerDAL.ManualInspectionSafetyAssessmentReportDAL;
using GxjtBHMS.SqlServerDAL.SpecialSafetyAssessmentReportDAL;
using GxjtBHMS.IDAL.Home;
using GxjtBHMS.SqlServerDAL.Home;
using GxjtBHMS.IDAL.AlarmDatasManagement;

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

            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<Eigenvalue_ConcreteStrainEigenvalueTable>>().To<ConcreteStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<Eigenvalue_SteelArchStrainEigenvalueTable>>().To<SteelArchStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<Eigenvalue_SteelLatticeStrainEigenvalueTable>>().To<SteelLatticeStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<Eigenvalue_DisplacementEigenvalueTable>>().To<DisplaymentDatasEigenValueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<Eigenvalue_CableForceEigenvalueTable>>().To<CableForceDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<Eigenvalue_HumidityEigenvalueTable>>().To<HumidityDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<Eigenvalue_TemperatureEigenvalueTable>>().To<TemperatureDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDAL<Eigenvalue_WindLoadEigenvalueTable>>().To<WindLoadDatasEigenvalueDAL>();



            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<Eigenvalue_ConcreteStrainEigenvalueTable>>().To<MonitorDatasQueryChartService<Eigenvalue_ConcreteStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<Eigenvalue_SteelArchStrainEigenvalueTable>>().To<MonitorDatasQueryChartService<Eigenvalue_SteelArchStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<Eigenvalue_SteelLatticeStrainEigenvalueTable>>().To<MonitorDatasQueryChartService<Eigenvalue_SteelLatticeStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<Eigenvalue_DisplacementEigenvalueTable>>().To<MonitorDatasQueryChartService<Eigenvalue_DisplacementEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<Eigenvalue_CableForceEigenvalueTable>>().To<MonitorDatasQueryChartService<Eigenvalue_CableForceEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<Eigenvalue_HumidityEigenvalueTable>>().To<MonitorDatasQueryChartService<Eigenvalue_HumidityEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<Eigenvalue_TemperatureEigenvalueTable>>().To<MonitorDatasQueryChartService<Eigenvalue_TemperatureEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<Eigenvalue_WindLoadEigenvalueTable>>().To<MonitorDatasQueryChartService<Eigenvalue_WindLoadEigenvalueTable>>();


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

            ////安全预警Hub推送DAL注入
            //_ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_CableForceTable>>().To<CableForce_SafetyPreWarningRealTimePushDAL>();
            //_ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_DisplacementTable>>().To<Displacement_SafetyPreWarningRealTimePushDAL>();
            //_ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_WindLoadTable>>().To<WindLoad_SafetyPreWarningRealTimePushDAL>();
            //_ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_TemperatureTable>>().To<Temperature_SafetyPreWarningRealTimePushDAL>();




            //报警数据绑定
            _ninjectKernel.Bind<IAlarmDatasQueryService<SafetyPreWarning_CableForceTable>>().To<AlarmDatasQueryService<SafetyPreWarning_CableForceTable>>();
            _ninjectKernel.Bind<IAlarmDatasQueryDAL<SafetyPreWarning_CableForceTable>>().To<CableForceAlarmDatasDAL>();
            _ninjectKernel.Bind<IAlarmDatasFileSystemService<SafetyPreWarning_CableForceTable>>().To<AlarmDatasFileSystemService<SafetyPreWarning_CableForceTable>>();

            //一级安全评估
            _ninjectKernel.Bind<IGetFirstLevelSafetyAssessmentReportDAL>().To<GetFirstLevelSafetyAssessmentReportDAL>();

            _ninjectKernel.Bind<IAlarmDatasQueryService<SafetyPreWarning_DisplacementTable>>().To<AlarmDatasQueryService<SafetyPreWarning_DisplacementTable>>();
            _ninjectKernel.Bind<IAlarmDatasQueryDAL<SafetyPreWarning_DisplacementTable>>().To<DisplacementAlarmDatasDAL>();
            _ninjectKernel.Bind<IAlarmDatasFileSystemService<SafetyPreWarning_DisplacementTable>>().To<AlarmDatasFileSystemService<SafetyPreWarning_DisplacementTable>>();

            _ninjectKernel.Bind<IAlarmDatasQueryService<SafetyPreWarning_TemperatureTable>>().To<AlarmDatasQueryService<SafetyPreWarning_TemperatureTable>>();
            _ninjectKernel.Bind<IAlarmDatasQueryDAL<SafetyPreWarning_TemperatureTable>>().To<TemperatureAlarmDatasDAL>();
            _ninjectKernel.Bind<IAlarmDatasFileSystemService<SafetyPreWarning_TemperatureTable>>().To<AlarmDatasFileSystemService<SafetyPreWarning_TemperatureTable>>();

            _ninjectKernel.Bind<IAlarmDatasQueryService<SafetyPreWarning_WindLoadTable>>().To<AlarmDatasQueryService<SafetyPreWarning_WindLoadTable>>();
            _ninjectKernel.Bind<IAlarmDatasQueryDAL<SafetyPreWarning_WindLoadTable>>().To<WindLoadAlarmDatasDAL>();
            _ninjectKernel.Bind<IAlarmDatasFileSystemService<SafetyPreWarning_WindLoadTable>>().To<AlarmDatasFileSystemService<SafetyPreWarning_WindLoadTable>>();

            //二级安全评估绑定
            _ninjectKernel.Bind<IGetSecondLevelSafetyAssessmentReportDAL>().To<GetSecondLevelSafetyAssessmentReportDAL>();
            _ninjectKernel.Bind<IGetSecondLevelSafetyAssessmentStateDAL>().To<GetSecondLevelSafetyAssessmentStateDAL>();

            //专项安全评估绑定
            _ninjectKernel.Bind<IGetSpecialSafetyAssessmentReportDAL>().To<GetSpecialSafetyAssessmentReportDAL>();


            _ninjectKernel.Bind<IGetManualInspectionSafetyAssessmentReportDAL>().To<GetManualInspectionSafetyAssessmentReportDAL>();
            _ninjectKernel.Bind<IGetManualInspectionSafetyAssessmentStateDAL>().To<GetManualInspectionSafetyAssessmentStateDAL>();



            //主页中安全状态评估结果查询绑定
            _ninjectKernel.Bind<IGetFirstLevelSafetyAssessmentReportDisplacementResultDAL>().To<GetFirstLevelSafetyAssessmentReportDisplacementResultDAL>();

            //原始数据下载绑定
            _ninjectKernel.Bind<IOriginalDatasDownloadDAL>().To<OriginalDatasDownloadDAL>();
            //特征值数据下载绑定
            _ninjectKernel.Bind<IMonitoringDatasEigenvalueDownloadDAL>().To<MonitoringDatasEigenvalueDownloadDAL>();

        }
    }
}
