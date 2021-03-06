﻿using GxjtBHMS.DependencyInjection;
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
    public class DisplacementDatasTicker
    {
        //Singleton instance
        readonly static Lazy<DisplacementDatasTicker> _instance = new Lazy<DisplacementDatasTicker>(() => new DisplacementDatasTicker(GlobalHost.ConnectionManager.GetHubContext<DisplacementDatasRealTimeMonitoringHub>().Clients));
        readonly int _updateInterval = ApplicationSettingsFactory.GetApplicationSettings().RealReadDatasInterval;
        volatile bool _updatingDisplacementDatas = false;
        readonly object _updateDisplacementDatasLock = new object();
        Timer _timer;
        IDisplacementRealTimeDatasService _realTimeDatasService;
        DisplacementDatasTicker(IHubConnectionContext<dynamic> clients)
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<IDisplacementRealTimeDatasService>();
            Clients = clients;
            //定时器
            _timer = new Timer(UpdateDisplacementDatas, null, 0, _updateInterval);
        }

        IHubConnectionContext<dynamic> Clients { get; set; }
        /// <summary>
        /// 获取单实例
        /// </summary>
        public static DisplacementDatasTicker Instance { get { return _instance.Value; } }

        void UpdateDisplacementDatas(object state)
        {
            lock (_updateDisplacementDatasLock)
            {
                if (!_updatingDisplacementDatas)
                {
                    _updatingDisplacementDatas = true;
                    var models = GetRealDatasSource();
                    BroadcastDisplacementDatas(models);
                    _updatingDisplacementDatas = false;
                }
            }
        }

        void BroadcastDisplacementDatas(IEnumerable<IncludeSectionWarningColorDataModel> models)
        {
            Clients.All.RealTimeDisplayDatas(models);
        }

        private IEnumerable<IncludeSectionWarningColorDataModel> GetRealDatasSource()
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(4).ToArray();
            return _realTimeDatasService.GetWarningDisplacementDatasBy(sectionIds);
        }

        internal IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return GetRealDatasSource();
        }
    }
}