using GxjtBHMS.DependencyInjection;
using GxjtBHMS.Infrastructure.Configuration;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using GxjtBHMS.Web.RealTimeMonitoringHub;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace GxjtBHMS.Web.Models
{
    public class CableForceDatasTicker
    {
        //Singleton instance
        readonly static Lazy<CableForceDatasTicker> _instance = new Lazy<CableForceDatasTicker>(() => new CableForceDatasTicker(GlobalHost.ConnectionManager.GetHubContext<CableForceDatasRealTimeMonitoringHub>().Clients));
        readonly int _updateInterval = ApplicationSettingsFactory.GetApplicationSettings().RealReadDatasInterval;
        volatile bool _updatingCableForceDatas = false;
        readonly object _updateCableForceDatasLock = new object();
        Timer _timer;
        ICableForceRealTimeDatasService _realTimeDatasService;
        CableForceDatasTicker(IHubConnectionContext<dynamic> clients)
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<ICableForceRealTimeDatasService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateCableForceDatas, null, 0, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static CableForceDatasTicker Instance { get { return _instance.Value; } }

        void UpdateCableForceDatas(object state)
        {
            lock (_updateCableForceDatasLock)
            {
                if (!_updatingCableForceDatas)
                {
                    _updatingCableForceDatas = true;
                    var models = GetRealDatasSource(); ;
                    BroadcastCableForceDatas(models);
                    _updatingCableForceDatas = false;
                }
            }
        }

        void BroadcastCableForceDatas(IEnumerable<IncludeSectionWarningColorDataModel> models)
        {
            Clients.All.RealTimeDisplayDatas(models);
        }

        private IEnumerable<IncludeSectionWarningColorDataModel> GetRealDatasSource()
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(5).ToArray();
            return _realTimeDatasService.GetWarningCableForceDatasBy(sectionIds);
        }

        internal IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return GetRealDatasSource();
        }
    }
}