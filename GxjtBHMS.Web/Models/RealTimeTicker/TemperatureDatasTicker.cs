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
    public class TemperatureDatasTicker
    {
        //Singleton instance
        readonly static Lazy<TemperatureDatasTicker> _instance = new Lazy<TemperatureDatasTicker>(() => new TemperatureDatasTicker(GlobalHost.ConnectionManager.GetHubContext<TemperatureDatasRealTimeMonitoringHub>().Clients));
        readonly int _updateInterval = ApplicationSettingsFactory.GetApplicationSettings().RealReadDatasInterval;
        volatile bool _updatingTemperatureDatas = false;
        readonly object _updateTemperatureDatasLock = new object();
        Timer _timer;
        ITemperatureRealTimeDatasService _realTimeDatasService;
        TemperatureDatasTicker(IHubConnectionContext<dynamic> clients)
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<ITemperatureRealTimeDatasService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateTemperatureDatas, null, 0, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static TemperatureDatasTicker Instance { get { return _instance.Value; } }

        void UpdateTemperatureDatas(object state)
        {
            lock (_updateTemperatureDatasLock)
            {
                if (!_updatingTemperatureDatas)
                {
                    _updatingTemperatureDatas = true;
                    var models = GetRealDatasSource();
                    BroadcastTemperatureDatas(models);
                    _updatingTemperatureDatas = false;
                }
            }
        }

        void BroadcastTemperatureDatas(IEnumerable<IncludeSectionWarningColorDataModel> models)
        {
            Clients.All.RealTimeDisplayDatas(models);
        }

        private IEnumerable<IncludeSectionWarningColorDataModel> GetRealDatasSource()
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(7).ToArray();
            return _realTimeDatasService.GetWarningTemperatureDatasBy(sectionIds);
        }

        internal IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return GetRealDatasSource();
        }
    }
}