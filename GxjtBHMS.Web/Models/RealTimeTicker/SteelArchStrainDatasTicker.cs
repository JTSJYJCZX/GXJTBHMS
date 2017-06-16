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
    public class SteelArchStrainDatasTicker
    {
        //Singleton instance
        readonly static Lazy<SteelArchStrainDatasTicker> _instance = new Lazy<SteelArchStrainDatasTicker>(() => new SteelArchStrainDatasTicker(GlobalHost.ConnectionManager.GetHubContext<SteelArchStrainDatasRealTimeMonitoringHub>().Clients));
        readonly int _updateInterval = ApplicationSettingsFactory.GetApplicationSettings().RealReadDatasInterval;
        volatile bool _updatingSteelArchStrainDatas = false;
        readonly object _updateSteelArchStrainDatasLock = new object();
        Timer _timer;
        ISteelArchStrainRealTimeDatasService _realTimeDatasService;

        SteelArchStrainDatasTicker(IHubConnectionContext<dynamic> clients)
        {
          
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<ISteelArchStrainRealTimeDatasService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateSteelArchStrainDatas, null, 0, _updateInterval);
       
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static SteelArchStrainDatasTicker Instance { get { return _instance.Value; } }

        void UpdateSteelArchStrainDatas(object state)
        {
            lock (_updateSteelArchStrainDatasLock)
            {
                if (!_updatingSteelArchStrainDatas)
                {
                    _updatingSteelArchStrainDatas = true;
                    
                    var models = GetRealDatasSource();
                                
                    BroadcastSteelArchStrainDatas(models);
                   
                    _updatingSteelArchStrainDatas = false;
                }
            }
        }

        void BroadcastSteelArchStrainDatas(IEnumerable<IncludeSectionWarningColorDataModel> models)
        {
            Clients.All.RealTimeDisplayDatas(models);
        }

        private IEnumerable<IncludeSectionWarningColorDataModel> GetRealDatasSource()
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(1).ToArray();
            return _realTimeDatasService.GetWarningStrainDatasBy(sectionIds);
        }

        internal IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return GetRealDatasSource();
        }
    }
}