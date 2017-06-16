using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.Implementations;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using GxjtBHMS.Service.SafetyPreWarningRealTimeHubService;
using GxjtBHMS.SqlServerDAL;
using GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL;
using Ninject;
using System;
using System.Web.Mvc;
using GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService;
using GxjtBHMS.Service.Interfaces.FirstLevelAssessmInerfaces;
using GxjtBHMS.Models.FirstLevelSafetyAssessmentTable;
using GxjtBHMS.SqlServerDAL.FirstLevelSafetyAssessmentReportDAL;
using GxjtBHMS.IDAL.GetFirstLevelSafetyAssessmentReport;
using GxjtBHMS.IDAL.AlarmDatasManagement;
using GxjtBHMS.Service.Interfaces.AlarmDatasQueryServiceInerfaces;
using GxjtBHMS.Service.Implementations.AlarmDatasManagement;
using GxjtBHMS.Service.AnomalousEventManagementQuery;
using GxjtBHMS.IDAL.AnomalousEventIDAL;
using GxjtBHMS.SqlServerDAL.AnomalousEventDAL;
using GxjtBHMS.IDAL.SafetyPreWarning;
using GxjtBHMS.SqlServerDAL.SafetyPreWarningDAL;

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



            ////获取安全预警数据注入
            _ninjectKernel.Bind<ISafetyPreWarningRealTimePushService>().To<SafetyPreWarningRealTimePushService>();


            //安全预警Hub推送DAL注入
            _ninjectKernel.Bind<ISafetyPreWarningRealTimePushDAL>().To<SafetyPreWarningRealTimePushDAL>();



            //一级安全评估报告下载
            _ninjectKernel.Bind<IFirstLevelAssessmReportDownloadFileInerfaces>().To<FirstLevelAssessmReportDownloadFileService>();
           
            _ninjectKernel.Bind<IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentExceptionRecordTable>>().To<FirstLevelOfSafetyAssessmentExceptionRecordDAL>();
            _ninjectKernel.Bind<IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelOfSafetyAssessmentResultsTable>>().To<FirstLevelOfSafetyAssessmentResultsDAL>();
            _ninjectKernel.Bind<IFirstLevelAssessmentDAL<FirstAssessment_FirstLevelSafetyAssessmentReportTable>>().To<FirstLevelSafetyAssessmentReportDAL>();

            _ninjectKernel.Bind<AbstractFirstLevelSafetyReport>().To<NPOIReportProcessor>();

            //报警数据管理注入
            _ninjectKernel.Bind<IAlarmDatasQueryDAL<SafetyPreWarning_CableForceTable>>().To<CableForceAlarmDatasDAL>();
            //异常事件管理
            _ninjectKernel.Bind<IAnomalousEventManagementsFileSystemService>().To<AnomalousEventFileSystemService>();

            _ninjectKernel.Bind<IAnomalousEventManagementService>().To<AnomalousEventQueryService>();
            _ninjectKernel.Bind<IAnomalousEventManagementQueryService>().To<AnomalousEventManagementQueryService>();
            _ninjectKernel.Bind<IAnomalousEventQueryDAL>().To<AnomalousQueryDAL>();

            //预加载应用程序管理接口
            _ninjectKernel.Bind<IPreloadDataSet>().To<GeneralPreloadDataSet>();
        }
    }
}
