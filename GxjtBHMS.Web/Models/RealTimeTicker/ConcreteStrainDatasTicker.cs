using GxjtBHMS.DependencyInjection;
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
        readonly TimeSpan _updateInterval = TimeSpan.FromMilliseconds(10500);
        volatile bool _updatingStockPrices = false;
        readonly object _updateStockPricesLock = new object();
        Timer _timer;
        IConcreteStrainRealTimeDatasService _realTimeDatasService;
        ConcreteStrainDatasTicker(IHubConnectionContext<dynamic> clients)
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<IConcreteStrainRealTimeDatasService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateStockPrices, null, _updateInterval, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static ConcreteStrainDatasTicker Instance { get { return _instance.Value; } }

        void UpdateStockPrices(object state)
        {
            lock (_updateStockPricesLock)
            {
                if (!_updatingStockPrices)
                {
                    _updatingStockPrices = true;
                    var sectionIds = _realTimeDatasService.GetSectionIdsBy(3).ToArray();
                    var models = _realTimeDatasService.GetWarningStrainDatasBy(sectionIds);
                    BroadcastStockPrice(models);
                    _updatingStockPrices = false;
                }
            }
        }

        void BroadcastStockPrice(IEnumerable<IncludeSectionWarningColorDataModel> models)
        {
            Clients.All.RealTimeDisplayDatas(models);
        }
    }
}