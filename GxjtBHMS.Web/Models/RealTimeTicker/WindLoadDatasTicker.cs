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
    public class WindLoadDatasTicker
    {
        //Singleton instance
        readonly static Lazy<WindLoadDatasTicker> _instance = new Lazy<WindLoadDatasTicker>(() => new WindLoadDatasTicker(GlobalHost.ConnectionManager.GetHubContext<WindLoadDatasRealTimeMonitoringHub>().Clients));
        readonly int _updateInterval = ApplicationSettingsFactory.GetApplicationSettings().RealReadDatasInterval;
        volatile bool _updatingWindLoadDatas = false;
        readonly object _updateWindLoadDatasLock = new object();
        Timer _timer;
        IWindLoadRealTimeDatasService _realTimeDatasService;
        WindLoadDatasTicker(IHubConnectionContext<dynamic> clients)
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<IWindLoadRealTimeDatasService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateWindLoadDatas, null, 0, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static WindLoadDatasTicker Instance { get { return _instance.Value; } }

        void UpdateWindLoadDatas(object state)
        {
            lock (_updateWindLoadDatasLock)
            {
                if (!_updatingWindLoadDatas)
                {
                    _updatingWindLoadDatas = true;
                    var models = GetRealDatasSource();
                    BroadcastWindLoadDatas(models);
                    _updatingWindLoadDatas = false;
                }
            }
        }

        void BroadcastWindLoadDatas(IEnumerable<IncludeSectionWarningColorDataModel> models)
        {
            Clients.All.RealTimeDisplayDatas(models);
        }

        private IEnumerable<IncludeSectionWarningColorDataModel> GetRealDatasSource()
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(8).ToArray();
            return _realTimeDatasService.GetWarningWindLoadDatasBy(sectionIds);
        }

        internal IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return GetRealDatasSource();
        }
    }
}