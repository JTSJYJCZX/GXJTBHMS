﻿using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class DisplacementDatasRealTimeMonitoringHub : Hub
    {
        IDisplacementRealTimeDatasService _realTimeDatasService;

        public DisplacementDatasRealTimeMonitoringHub()
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<IDisplacementRealTimeDatasService>();

        }

        public void DisplayWarningDisplacementDatas(int testTypeId)
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(testTypeId).ToArray();
            
            while (true == true)
            {
                var models = _realTimeDatasService.GetWarningDisplacementDatasBy(sectionIds);
                Clients.All.RealTimeDisplayDatas(models);
                Thread.Sleep(5000);
            }
        }
    }
}