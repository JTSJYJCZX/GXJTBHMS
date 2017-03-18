﻿using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.Implementations;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.SqlServerDAL;
using Ninject;

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

            _ninjectKernel.Bind<IConcreteStrainDatasOriginalValueDownLoadService>().To<ConcreteStrainDatasOriginalValueDownLoadService>();
            _ninjectKernel.Bind<IConcreteStrainDatasOriginalValueDAL>().To<ConcreteStrainDatasOriginalValueDAL>();


            _ninjectKernel.Bind<IConcreteStrainDatasEigenvalueQueryService>().To<ConcreteStrainDatasEigenvalueQueryService>();
            _ninjectKernel.Bind<IConcreteStrainDatasEigenValueDAL>().To<ConcreteStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<ISteelArchStrainDatasEigenvalueQueryService>().To<SteelArchStrainDatasEigenvalueQueryService>();
            _ninjectKernel.Bind<ISteelArchStrainDatasEigenValueDAL>().To<SteelArchStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IDisplaymentDatasQueryService>().To<DisplaymentDatasQueryService>();
            _ninjectKernel.Bind<IDisplaymentDatasDAL>().To<DisplaymentDatasDAL>();
            _ninjectKernel.Bind<ICableForceDatasQueryService>().To<CableForceDatasQueryService>();
            _ninjectKernel.Bind<ICableForceDatasDAL>().To<CableForceDatasDAL>();
            _ninjectKernel.Bind<IHumidityDatasQueryService>().To<HumidityDatasQueryService>();
            _ninjectKernel.Bind<IHumidityDatasDAL>().To<HumidityDatasDAL>();
            _ninjectKernel.Bind<ITemperatureDatasQueryService>().To<TemperatureDatasQueryService>();
            _ninjectKernel.Bind<ITemperatureDatasDAL>().To<TemperatureDatasDAL>();

            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<ConcreteStrainEigenvalueTable>>().To<ConcreteStrainMonitorDatasQueryChartService>();
             _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<DisplacementTable>>().To<DisplaymentMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<CableForceTable>>().To<CableForceMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<HumidityTable>>().To<HumidityMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<TemperatureTable>>().To<TemperatureMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<SteelArchStrainEigenvalueTable>>().To<SteelArchStrainMonitorDatasQueryChartService>();


            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<ConcreteStrainTable>>().To<StrainMonitorDatasOriginalValueDownLoadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<ConcreteStrainEigenvalueTable>>().To<ConcreteStrainMonitorDatasEigenValueQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<DisplacementTable>>().To<DisplaymentMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<CableForceTable>>().To<CableForceMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<HumidityTable>>().To<HumidityMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<TemperatureTable>>().To<TemperatureMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<SteelArchStrainEigenvalueTable>>().To<SteelArchStrainMonitorDatasQueryFileSystemService>();


        }
    }
}
