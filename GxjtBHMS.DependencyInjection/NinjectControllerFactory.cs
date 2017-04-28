using GxjtBHMS.IDAL;
using GxjtBHMS.IDAL.SafetyPreWarning;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.Implementations;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using GxjtBHMS.Service.SafetyPreWarningRealTimeHubService;
using GxjtBHMS.SqlServerDAL;
using GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL;
using GxjtBHMS.SqlServerDAL.SafetyPreWarningRealTimePushDAL;
using Ninject;
using System;
using System.Web.Mvc;
using GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService;
using GxjtBHMS.Service.Interfaces.FirstLevelAssessmInerfaces;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.SqlServerDAL.FirstLevelSafetyAssessmentReportDAL;
using GxjtBHMS.IDAL.GetFirstLevelSafetyAssessmentReport;

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
            _ninjectKernel.Bind<ISteelArchStrainRealTimeDatasDAL>().To<SteelArchStrainRealTimeDatasDAL>();
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

            _ninjectKernel.Bind<ISafetyPreWarningRealTimePushService>().To<SafetyPreWarningRealTimePushService>();

            //获取单值安全预警数据注入
            _ninjectKernel.Bind<IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_CableForceTable>>().To<GetOneTypeSafetyPreWarningRealTimePushServiceBase<SafetyPreWarning_CableForceTable>>();
            _ninjectKernel.Bind<IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_DisplacementTable>>().To<GetOneTypeSafetyPreWarningRealTimePushServiceBase<SafetyPreWarning_DisplacementTable>>();
            _ninjectKernel.Bind<IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_TemperatureTable>>().To<GetOneTypeSafetyPreWarningRealTimePushServiceBase<SafetyPreWarning_TemperatureTable>>();
            _ninjectKernel.Bind<IGetOneTypeSafetyPreWarningRealTimePushService<SafetyPreWarning_WindLoadTable>>().To<GetOneTypeSafetyPreWarningRealTimePushServiceBase<SafetyPreWarning_WindLoadTable>>();

            //安全预警Hub推送DAL注入
            _ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_CableForceTable>>().To<CableForce_SafetyPreWarningRealTimePushDAL>();
            _ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_DisplacementTable>>().To<Displacement_SafetyPreWarningRealTimePushDAL>();
            _ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_WindLoadTable>>().To<WindLoad_SafetyPreWarningRealTimePushDAL>();
            _ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL<SafetyPreWarning_TemperatureTable>>().To<Temperature_SafetyPreWarningRealTimePushDAL>();


            //一级安全评估报告下载
            _ninjectKernel.Bind<IFirstLevelAssessmReportDownloadFileInerfaces>().To<FirstLevelAssessmReportDownloadFileService>();
           
            _ninjectKernel.Bind<IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable>>().To<FirstLevelOfSafetyAssessmentExceptionRecordDAL>();
            _ninjectKernel.Bind<IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable>>().To<FirstLevelOfSafetyAssessmentResultsDAL>();
            _ninjectKernel.Bind<IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelSafetyAssessmentReportTable>>().To<FirstLevelSafetyAssessmentReportDAL>();
            //报警数据管理注入
            _ninjectKernel.Bind<IAlarmDatasQueryDAL<SafetyPreWarning_CableForceTable>>().To<CableForceAlarmDatasDAL>();            

        }
    }
}
