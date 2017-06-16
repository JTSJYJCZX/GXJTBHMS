using GxjtBHMS.DependencyInjection;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ViewModels.SafetyPreWarning;
using GxjtBHMS.Web.SafetyPreWarningRealTimeHub;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using System;
using System.Threading;

namespace GxjtBHMS.Web.Models
{
    public class SafetyPreWarningTicker
    {
        //Singleton instance
        readonly static Lazy<SafetyPreWarningTicker> _instance = new Lazy<SafetyPreWarningTicker>(() => new SafetyPreWarningTicker(GlobalHost.ConnectionManager.GetHubContext<SafetyPreWarningHub>().Clients));
        readonly int _updateInterval = ApplicationSettingsFactory.GetApplicationSettings().RealReadDatasInterval;
        volatile bool _updatingSafetyPreWarning;
        readonly object _updateSafetyPreWarningLock = new object();
        Timer _timer;
        ISafetyPreWarningRealTimePushService _sfpwrtp;
        SafetyPreWarningTicker(IHubConnectionContext<dynamic> clients)
        {
            _sfpwrtp = new NinjectControllerFactory().GetInstance<ISafetyPreWarningRealTimePushService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateSafetyPreWarning, null, 0, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static SafetyPreWarningTicker Instance { get { return _instance.Value; } }

        void UpdateSafetyPreWarning(object state)
        {
            lock (_updateSafetyPreWarningLock)
            {
                if (!_updatingSafetyPreWarning)
                {
                    _updatingSafetyPreWarning = true;
                    var model = GetRealDatasSource();
                    BroadcastSafetyPreWarning(model);
                    _updatingSafetyPreWarning = false;
                }
            }
        }

        void BroadcastSafetyPreWarning(AllSafetyPreWarningStateDataModel models)
        {
            Clients.All.SafetyWarningStateRealTimePushDatas(models);
        }

        private AllSafetyPreWarningStateDataModel GetRealDatasSource()
        {
            return _sfpwrtp.GetSafetyPreWarningRealTimePushModel();


        }

        internal AllSafetyPreWarningStateDataModel GetInitDatas()
        {
            return GetRealDatasSource();
        }
    }
}