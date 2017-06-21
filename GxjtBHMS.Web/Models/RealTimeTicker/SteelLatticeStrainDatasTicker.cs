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
    public class SteelLatticeStrainDatasTicker
    {
        //Singleton instance
        readonly static Lazy<SteelLatticeStrainDatasTicker> _instance = new Lazy<SteelLatticeStrainDatasTicker>(() => new SteelLatticeStrainDatasTicker(GlobalHost.ConnectionManager.GetHubContext<SteelLatticeStrainDatasRealTimeMonitoringHub>().Clients));
        readonly int _updateInterval = ApplicationSettingsFactory.GetApplicationSettings().RealReadDatasInterval;
        volatile bool _updatingSteelLatticeStrainDatas = false;
        readonly object _updateSteelLatticeStrainDatasLock = new object();
        Timer _timer;
        ISteelLatticeStrainRealTimeDatasService _realTimeDatasService;
        SteelLatticeStrainDatasTicker(IHubConnectionContext<dynamic> clients)
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<ISteelLatticeStrainRealTimeDatasService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateSteelLatticeStrainDatas, null, 0, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static SteelLatticeStrainDatasTicker Instance { get { return _instance.Value; } }

        void UpdateSteelLatticeStrainDatas(object state)
        {
            lock (_updateSteelLatticeStrainDatasLock)
            {
                if (!_updatingSteelLatticeStrainDatas)
                {
                    _updatingSteelLatticeStrainDatas = true;
                    var models = GetRealDatasSource();
                    BroadcastSteelLatticeStrainDatas(models);
                    _updatingSteelLatticeStrainDatas = false;
                }
            }
        }

        void BroadcastSteelLatticeStrainDatas(IEnumerable<IncludeSectionWarningColorDataModel> models)
        {
            Clients.All.RealTimeDisplayDatas(models);
        }

        private IEnumerable<IncludeSectionWarningColorDataModel> GetRealDatasSource()
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(2).ToArray();
            return _realTimeDatasService.GetWarningStrainDatasBy(sectionIds);
        }

        internal IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return GetRealDatasSource();
        }
    }
}