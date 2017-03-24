using GxjtBHMS.IDAL;
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
using GxjtBHMS.Service.Interfaces.MonitoringDatasQueryServiceInerfaces;

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

            _ninjectKernel.Bind<IConcreteStrainDatasEigenValueDAL>().To<ConcreteStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<ISteelArchStrainDatasEigenValueDAL>().To<SteelArchStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<ISteelLatticeStrainDatasEigenValueDAL>().To<SteelLatticeStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IDisplaymentDatasEigenValueDAL>().To<DisplaymentDatasEigenValueDAL>();
            _ninjectKernel.Bind<ICableForceDatasEigenvalueDAL>().To<CableForceDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IHumidityDatasEigenvalueDAL>().To<HumidityDatasEigenvalueDAL>();
            _ninjectKernel.Bind<ITemperatureDatasEigenvalueDAL>().To<TemperatureDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IWindLoadDatasEigenValueDAL>().To<WindLoadDatasEigenvalueDAL>();


            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<ConcreteStrainEigenvalueTable>>().To<ConcreteStrainMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<DisplacementEigenvalueTable>>().To<DisplaymentMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<CableForceEigenValueTable>>().To<CableForceMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<HumidityEigenvalueTable>>().To<HumidityMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<TemperatureEigenvalueTable>>().To<TemperatureMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<SteelArchStrainEigenvalueTable>>().To<SteelArchStrainMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<SteelLatticeStrainEigenvalueTable>>().To<SteelLatticeStrainMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<WindLoadEigenvalueTable>>().To<WindLoadMonitorDatasQueryChartService>();

            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelArchStrainTable>>().To<SteelArchStrainMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<ConcreteStrainTable>>().To<ConcreteStrainMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelLatticeStrainTable>>().To<SteelLatticeStrainMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<DisplacementTable>>().To<DisplacementMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<CableForceTable>>().To<CableForceMonitorDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<TemperatureTable>>().To<TemperatureDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<HumidityTable>>().To<HumidityDatasOriginalValueDownloadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<WindLoadTable>>().To<WindLoadDatasOriginalValueDownloadFileSystemService>();


            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<ConcreteStrainEigenvalueTable>>().To<ConcreteStrainMonitorDatasEigenValueQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<DisplacementEigenvalueTable>>().To<DisplaymentMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<CableForceEigenValueTable>>().To<CableForceMonitorDatasEigenValueQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<HumidityEigenvalueTable>>().To<HumidityMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<TemperatureEigenvalueTable>>().To<TemperatureMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelArchStrainEigenvalueTable>>().To<SteelArchStrainMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<SteelLatticeStrainEigenvalueTable>>().To<SteelLatticeStrainMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasQueryFileSystemService<WindLoadEigenvalueTable>>().To<WindLoadMonitorDatasEigenValueQueryFileSystemService>();

        }
    }
}
