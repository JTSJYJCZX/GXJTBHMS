using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.Implementations;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.SqlServerDAL;
using GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL;
using GxjtBHMS.SqlServerDAL.ThresholdValueDatasDAL;
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


            _ninjectKernel.Bind<IStrainDataRealTimeDisplayService>().To<StrainDataRealTimeDisplayService>();
            _ninjectKernel.Bind<IRealTimeStrainDatasDAL>().To<RealTimeStrainDatasDAL>();
            _ninjectKernel.Bind<IDisplaymentDataRealTimeDisplayService>().To<DisplaymentDataRealTimeDisplayService>();
            _ninjectKernel.Bind<IRealTimeDisplaymentDatasDAL>().To<RealTimeDisplaymentDatasDAL>();
            _ninjectKernel.Bind<ICableForceDataRealTimeDisplayService>().To<CableForceDataRealTimeDisplayService>();
            _ninjectKernel.Bind<IRealTimeCableForceDatasDAL>().To<RealTimeCableForceDatasDAL>();
            _ninjectKernel.Bind<ITemperatureDataRealTimeDisplayService>().To<TemperatureDataRealTimeDisplayService>();
            _ninjectKernel.Bind<IRealTimeTemperatureDatasDAL>().To<RealTimeTemperatureDatasDAL>();

            _ninjectKernel.Bind<IHumidityDataRealTimeDisplayService>().To<HumidityDataRealTimeDisplayService>();
            _ninjectKernel.Bind<IRealTimeHumidityDatasDAL>().To<RealTimeHumidityDatasDAL>();

            _ninjectKernel.Bind<IThresholdValueSettingDAL<ConcreteStrainThresholdValueTable>>().To<ConcreteStrainThresholdValueSettingDAL>();
            //_ninjectKernel.Bind<IThresholdValueSettingService>().To<ThresholdValueSettingService>();
            _ninjectKernel.Bind<IStrainThresholdValueGettingDAL>().To<StrainThresholdValueGettingDAL>();
            _ninjectKernel.Bind<IDisplaymentThresholdValueGettingDAL>().To<DisplaymentThresholdValueGettingDAL>();
            _ninjectKernel.Bind<ICableForceThresholdValueGettingDAL>().To<CableForceThresholdValueGettingDAL>();
            _ninjectKernel.Bind<ITemperatureThresholdValueGettingDAL>().To<TemperatureThresholdValueGettingDAL>();
            _ninjectKernel.Bind<IHumidityThresholdValueGettingDAL>().To<HumidityThresholdValueGettingDAL>();

            _ninjectKernel.Bind<IFileConverter>().To<ExcelFileConverter>();
        }
    }
}
