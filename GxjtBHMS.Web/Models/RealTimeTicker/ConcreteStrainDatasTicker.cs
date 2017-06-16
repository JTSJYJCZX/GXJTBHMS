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
    public class ConcreteStrainDatasTicker
    {
        //Singleton instance
        readonly static Lazy<ConcreteStrainDatasTicker> _instance = new Lazy<ConcreteStrainDatasTicker>(() => new ConcreteStrainDatasTicker(GlobalHost.ConnectionManager.GetHubContext<ConcreteStrainDatasRealTimeMonitoringHub>().Clients));
        readonly int _updateInterval = ApplicationSettingsFactory.GetApplicationSettings().RealReadDatasInterval;
        volatile bool _updatingConcreteStrainDatas = false;
        readonly object _updateConcreteStrainDatasLock = new object();
        Timer _timer;
        IConcreteStrainRealTimeDatasService _realTimeDatasService;
        ConcreteStrainDatasTicker(IHubConnectionContext<dynamic> clients)
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<IConcreteStrainRealTimeDatasService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateConcreteStrainDatas, null, 0, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static ConcreteStrainDatasTicker Instance { get { return _instance.Value; } }

        void UpdateConcreteStrainDatas(object state)
        {
            lock (_updateConcreteStrainDatasLock)
            {
                if (!_updatingConcreteStrainDatas)
                {
                    _updatingConcreteStrainDatas = true;
                    var models = GetRealDatasSource(); ;
                    BroadcastConcreteStrainDatas(models);
                    _updatingConcreteStrainDatas = false;
                }
            }
        }

        void BroadcastConcreteStrainDatas(IEnumerable<IncludeSectionWarningColorDataModel> models)
        {
            Clients.All.RealTimeDisplayDatas(models);
        }

        IEnumerable<IncludeSectionWarningColorDataModel> GetRealDatasSource()
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(3).ToArray();
            return _realTimeDatasService.GetWarningStrainDatasBy(sectionIds);
        }

        internal IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return GetRealDatasSource();
        }
    }
}