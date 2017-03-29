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

            //_ninjectKernel.Bind<IConcreteStrainDatasOriginalValueDownloadService>().To<ConcreteStrainDatasOriginalValueDownloadService>();
            _ninjectKernel.Bind<IConcreteStrainDatasOriginalValueDAL>().To<ConcreteStrainDatasOriginalValueDAL>();
            //_ninjectKernel.Bind<ISteelArchStrainDatasOriginalValueDownloadService>().To<SteelArchStrainDatasOriginalValueDownloadService>();
            _ninjectKernel.Bind<ISteelArchStrainDatasOriginalValueDAL>().To<SteelArchStrainDatasOriginalValueDAL>();
            //_ninjectKernel.Bind<ISteelLatticeStrainDatasOriginalValueDownloadService>().To<SteelLatticeStrainDatasOriginalValueDownloadService>();
            _ninjectKernel.Bind<ISteelLatticeStrainDatasOriginalValueDAL>().To<SteelLatticeStrainDatasOriginalValueDAL>();
            //_ninjectKernel.Bind<IDisplacementDatasOriginalValueDownloadService>().To<DisplacementDatasOriginalValueDownloadService>();
            _ninjectKernel.Bind<IDisplacementDatasOriginalValueDAL>().To<DisplacementDatasOriginalValueDAL>();
            //_ninjectKernel.Bind<ICableForceDatasOriginalValueDownloadService>().To<CableForceDatasOriginalValueDownloadService>();
            _ninjectKernel.Bind<ICableForceDatasOriginalValueDAL>().To<CableForceDatasOriginalValueDAL>();
            //_ninjectKernel.Bind<ITemperatureDatasOriginalValueDownloadService>().To<TemperatureDatasOriginalValueDownloadService>();
            _ninjectKernel.Bind<ITemperatureDatasOriginalValueDAL>().To<TemperatureDatasOriginalValueDAL>();
            //_ninjectKernel.Bind<IHumidityDatasOriginalValueDownloadService>().To<HumidityDatasOriginalValueDownloadService>();
            _ninjectKernel.Bind<IHumidityDatasOriginalValueDAL>().To<HumidityDatasOriginalValueDAL>();
            //_ninjectKernel.Bind<IWindLoadDatasOriginalValueDownloadService>().To<WindLoadDatasOriginalValueDownloadService>();
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

            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelArchStrainTable>>().To<SteelArchStrainMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelArchStrainTable>>().To<SteelArchStrainMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<ConcreteStrainTable>>().To<ConcreteStrainMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelLatticeStrainTable>>().To<SteelLatticeStrainMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<DisplacementTable>>().To<DisplacementMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<CableForceTable>>().To<CableForceMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<TemperatureTable>>().To<TemperatureDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<HumidityTable>>().To<HumidityDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<WindLoadTable>>().To<WindLoadDatasOriginalValueDownloadFileSystemService>();


           
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<ConcreteStrainEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<ConcreteStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelArchStrainEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<SteelArchStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelLatticeStrainEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<SteelLatticeStrainEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<DisplacementEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<DisplacementEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<CableForceEigenValueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<CableForceEigenValueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<HumidityEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<HumidityEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<TemperatureEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<TemperatureEigenvalueTable>>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<WindLoadEigenvalueTable>>().To<MonitorDatasEigenValueQueryFileSystemService<WindLoadEigenvalueTable>>();

            _ninjectKernel.Bind<IThresholdValueSettingDAL<SteelArchStrainThresholdValueTable>>().To<SteelArchStrainThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<SteelLatticeStrainThresholdValueTable>>().To<SteelLatticeStrainThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<WindLoadThresholdValueTable>>().To<WindLoadThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<ConcreteStrainThresholdValueTable>>().To<ConcreteStrainThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<DisplacementThresholdValueTable>>().To<DisplacementThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<CableForceThresholdValueTable>>().To<CableForceThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<HumidityThresholdValueTable>>().To<HumidityThresholdValueSettingDAL>();
            _ninjectKernel.Bind<IThresholdValueSettingDAL<TemperatureThresholdValueTable>>().To<TemperatureThresholdValueSettingDAL>();

            _ninjectKernel.Bind<IAbnormalThresholdValueSettingDAL>().To<AbnormalThresholdValueSettingDAL>();


        }
    }
}
