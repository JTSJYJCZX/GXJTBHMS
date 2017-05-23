using GxjtBHMS.DependencyInjection;
using GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using GxjtBHMS.Service.ViewModels.SafetyPreWarning;
using GxjtBHMS.Web.RealTimeMonitoringHub;
using GxjtBHMS.Web.SafetyPreWarningRealTimeHub;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace GxjtBHMS.Web.Models
{
    public class SafetyPreWarningTicker
    {
        //Singleton instance
        readonly static Lazy<SafetyPreWarningTicker> _instance = new Lazy<SafetyPreWarningTicker>(() => new SafetyPreWarningTicker(GlobalHost.ConnectionManager.GetHubContext<SafetyPreWarningHub>().Clients));
        readonly TimeSpan _updateInterval = TimeSpan.FromMilliseconds(10500);
        volatile bool _updatingStockPrices = false;
        readonly object _updateStockPricesLock = new object();
        Timer _timer;
        ISafetyPreWarningRealTimePushService _sfpwrtp;
        SafetyPreWarningTicker(IHubConnectionContext<dynamic> clients)
        {
            _sfpwrtp = new NinjectControllerFactory().GetInstance<ISafetyPreWarningRealTimePushService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateStockPrices, null, _updateInterval, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static SafetyPreWarningTicker Instance { get { return _instance.Value; } }

        void UpdateStockPrices(object state)
        {
            lock (_updateStockPricesLock)
            {
                if (!_updatingStockPrices)
                {
                    _updatingStockPrices = true;
                    var model = GetRealDatasSource();
                    BroadcastStockPrice(model);
                    _updatingStockPrices = false;
                }
            }
        }

        void BroadcastStockPrice(AllSafetyPreWarningStateDataModel models)
        {
            Clients.All.SafetyWarningStateRealTimePushDatas(models);
        }

        private AllSafetyPreWarningStateDataModel GetRealDatasSource()
        {
            var GetFirstLevelSafetyAssessmentReportListService = new GetFirstLevelSafetyAssessmentReportService();
            var LastReportTime = GetFirstLevelSafetyAssessmentReportListService.GetFirstSafetyAssessmentResult().FirstSafetyAssessmentReportTime_DateTime;
            var req = new GetSafetyWarningDetailRequest
            {
                StartTime = LastReportTime,
                EndTime = DateTime.Now
            };
            return _sfpwrtp.GetSafetyPreWarningRealTimePushModel(req);
        }

        internal AllSafetyPreWarningStateDataModel GetInitDatas()
        {
            return GetRealDatasSource();
        }
    }
}