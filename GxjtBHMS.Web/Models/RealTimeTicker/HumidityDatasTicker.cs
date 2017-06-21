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
    public class HumidityDatasTicker
    {
        //Singleton instance
        readonly static Lazy<HumidityDatasTicker> _instance = new Lazy<HumidityDatasTicker>(() => new HumidityDatasTicker(GlobalHost.ConnectionManager.GetHubContext<HumidityDatasRealTimeMonitoringHub>().Clients));
        readonly int _updateInterval = ApplicationSettingsFactory.GetApplicationSettings().RealReadDatasInterval;
        volatile bool _updatingHumidityDatas = false;
        readonly object _updateHumidityDatasLock = new object();
        Timer _timer;
        IHumidityRealTimeDatasService _realTimeDatasService;
        HumidityDatasTicker(IHubConnectionContext<dynamic> clients)
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<IHumidityRealTimeDatasService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateHumidityDatas, null, 0, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static HumidityDatasTicker Instance { get { return _instance.Value; } }

        void UpdateHumidityDatas(object state)
        {
            lock (_updateHumidityDatasLock)
            {
                if (!_updatingHumidityDatas)
                {
                    _updatingHumidityDatas = true;
                    var models = GetRealDatasSource();
                    BroadcastHumidityDatas(models);
                    _updatingHumidityDatas = false;
                }
            }
        }

        void BroadcastHumidityDatas(IEnumerable<IncludeSectionWarningColorDataModel> models)
        {
            Clients.All.RealTimeDisplayDatas(models);
        }

        private IEnumerable<IncludeSectionWarningColorDataModel> GetRealDatasSource()
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(6).ToArray();
            return _realTimeDatasService.GetWarningHumidityDatasBy(sectionIds);
        }

        internal IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return GetRealDatasSource();
        }
    }
}