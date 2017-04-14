using GxjtBHMS.IDAL;
using GxjtBHMS.Service.Implementations;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.SqlServerDAL;
using GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL;
using Ninject;
using System;
using System.Web.Mvc;

namespace GxjtBHMS.DependencyInjection
{
    /// <summary>
    /// 实现MVC控制器依赖注入的工厂类
    /// </summary>
    public class NinjectControllerFactory : DefaultControllerFactory
    {
        IKernel _ninjectKernel;

        public T GetInstance<T>()
        {
            return _ninjectKernel.Get<T>();
        }

        public NinjectControllerFactory()
        {
            _ninjectKernel = new StandardKernel();
            AddBinding();
        }

        protected override IController GetControllerInstance(System.Web.Routing.RequestContext requestContext, Type controllerType)
        {
            return controllerType == null ? null : (IController)_ninjectKernel.Get(controllerType);
        }

        void AddBinding()
        {
            _ninjectKernel.Bind<IAdminUserService>().To<AdminUserService>();
            _ninjectKernel.Bind<IUser>().To<UserDALImpl>();
            _ninjectKernel.Bind<IUserService>().To<UserService>();
            _ninjectKernel.Bind<IMonitoringTestTypeService>().To<MonitoringTestTypeService>();
            _ninjectKernel.Bind<IMonitoringTestTypeDAL>().To<MonitoringTestTypeDAL>();
            _ninjectKernel.Bind<IMonitoringPointsPositionService>().To<MonitoringPointsPositionService>();
            _ninjectKernel.Bind<IMonitoringPointsPositionDAL>().To<MonitoringPointsPositionDAL>();
            _ninjectKernel.Bind<IMonitoringPointsNumberService>().To<MonitoringPointsNumberService>();
            _ninjectKernel.Bind<IMonitoringPointsNumberDAL>().To<MonitoringPointsNumberDAL>();


            _ninjectKernel.Bind<ISteelArchStrainRealTimeDatasService>().To<SteelArchStrainRealTimeDatasService>();
            _ninjectKernel.Bind<ISteelArchStrainRealTimeDatasDAL >().To<SteelArchStrainRealTimeDatasDAL>();
            _ninjectKernel.Bind<ISteelLatticeStrainRealTimeDatasService>().To<SteelLatticeStrainRealTimeDatasService>();
            _ninjectKernel.Bind<ISteelLatticeStrainRealTimeDatasDAL>().To<SteelLatticeStrainRealTimeDatasDAL>();
            _ninjectKernel.Bind<IConcreteStrainRealTimeDatasService>().To<ConcreteStrainRealTimeDatasService>();
            _ninjectKernel.Bind<IConcreteStrainRealTimeDatasDAL>().To<ConcreteStrainRealTimeDatasDAL>();
            _ninjectKernel.Bind<ICableForceRealTimeDatasService>().To<CableForceRealTimeDatasService>();
            _ninjectKernel.Bind<ICableForceRealTimeDatasDAL>().To<CableForceRealTimeDatasDAL>();
            _ninjectKernel.Bind<IDisplacementRealTimeDatasService>().To<DisplacementRealTimeDatasService>();
            _ninjectKernel.Bind<IDisplacementRealTimeDatasDAL>().To<DisplacementRealTimeDatasDAL>();
            _ninjectKernel.Bind<IHumidityRealTimeDatasService>().To<HumidityRealTimeDatasService>();
            _ninjectKernel.Bind<IHumidityRealTimeDatasDAL>().To<HumidityRealTimeDatasDAL>();
            _ninjectKernel.Bind<ITemperatureRealTimeDatasService>().To<TemperatureRealTimeDatasService>();
            _ninjectKernel.Bind<ITemperatureRealTimeDatasDAL>().To<TemperatureRealTimeDatasDAL>();
            _ninjectKernel.Bind<IWindLoadRealTimeDatasService>().To<WindLoadRealTimeDatasService>();
            _ninjectKernel.Bind<IWindLoadRealTimeDatasDAL>().To<WindLoadRealTimeDatasDAL>();

            _ninjectKernel.Bind<IFileConverter>().To<ExcelFileConverter>();





            
        }
    }
}
