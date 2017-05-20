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
    public class WindLoadDatasTicker
    {
        //Singleton instance
        readonly static Lazy<WindLoadDatasTicker> _instance = new Lazy<WindLoadDatasTicker>(() => new WindLoadDatasTicker(GlobalHost.ConnectionManager.GetHubContext<WindLoadDatasRealTimeMonitoringHub>().Clients));
        readonly TimeSpan _updateInterval = TimeSpan.FromMilliseconds(10500);
        volatile bool _updatingStockPrices = false;
        readonly object _updateStockPricesLock = new object();
        Timer _timer;
        IWindLoadRealTimeDatasService _realTimeDatasService;
        WindLoadDatasTicker(IHubConnectionContext<dynamic> clients)
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<IWindLoadRealTimeDatasService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateStockPrices, null, _updateInterval, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static WindLoadDatasTicker Instance { get { return _instance.Value; } }

        void UpdateStockPrices(object state)
        {
            lock (_updateStockPricesLock)
            {
                if (!_updatingStockPrices)
                {
                    _updatingStockPrices = true;
                    var sectionIds = _realTimeDatasService.GetSectionIdsBy(8).ToArray();
                    var models = _realTimeDatasService.GetWarningWindLoadDatasBy(sectionIds);
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