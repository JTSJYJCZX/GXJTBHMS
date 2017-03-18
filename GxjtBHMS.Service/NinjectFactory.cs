using GxjtBHMS.IDAL;
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
            _ninjectKernel.Bind<ISteelLatticeStrainDatasEigenvalueQueryService>().To<SteelLatticeStrainDatasEigenvalueQueryService>();
            _ninjectKernel.Bind<ISteelLatticeStrainDatasEigenValueDAL>().To<SteelLatticeStrainDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IDisplaymentDatasEigenvalueQueryService>().To<DisplaymentDatasEigenvalueQueryService>();
            _ninjectKernel.Bind<IDisplaymentDatasEigenValueDAL>().To<DisplaymentDatasEigenValueDAL>();
            _ninjectKernel.Bind<ICableForceDatasEigenvalueQueryService>().To<CableForceDatasEigenvalueQueryService>();
            _ninjectKernel.Bind<ICableForceDatasEigenvalueDAL>().To<CableForceDatasEigenvalueDAL>();
            _ninjectKernel.Bind<IHumidityDatasQueryService>().To<HumidityDatasQueryService>();
            _ninjectKernel.Bind<IHumidityDatasDAL>().To<HumidityDatasDAL>();
            _ninjectKernel.Bind<ITemperatureDatasQueryService>().To<TemperatureDatasQueryService>();
            _ninjectKernel.Bind<ITemperatureDatasDAL>().To<TemperatureDatasDAL>();

            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<ConcreteStrainEigenvalueTable>>().To<ConcreteStrainMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<DisplacementEigenvalueTable>>().To<DisplaymentMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<CableForceEigenvalueTable>>().To<CableForceMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<HumidityTable>>().To<HumidityMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<TemperatureTable>>().To<TemperatureMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<SteelArchStrainEigenvalueTable>>().To<SteelArchStrainMonitorDatasQueryChartService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryChartService<SteelLatticeStrainEigenvalueTable>>().To<SteelLatticeStrainMonitorDatasQueryChartService>();


            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<ConcreteStrainTable>>().To<StrainMonitorDatasOriginalValueDownLoadFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<ConcreteStrainEigenvalueTable>>().To<ConcreteStrainMonitorDatasEigenValueQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<DisplacementEigenvalueTable>>().To<DisplaymentMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<CableForceEigenvalueTable>>().To<CableForceMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<HumidityTable>>().To<HumidityMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<TemperatureTable>>().To<TemperatureMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<SteelArchStrainEigenvalueTable>>().To<SteelArchStrainMonitorDatasQueryFileSystemService>();
            _ninjectKernel.Bind<IMonitorDatasEigenvalueQueryFileSystemService<SteelLatticeStrainEigenvalueTable>>().To<SteelLatticeStrainMonitorDatasQueryFileSystemService>();


        }
    }
}
