using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.DependencyInjection;
using System.Threading;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class HumidityDatasRealTimeMonitoringHub : Hub
    {
        IHumidityDataRealTimeDisplayService _humidityDataRealTimeDisplayService;
        public HumidityDatasRealTimeMonitoringHub()
        {
            _humidityDataRealTimeDisplayService = new NinjectControllerFactory().
                GetInstance<IHumidityDataRealTimeDisplayService>();
        }
        public void DisplayWarningHumidityDatas(int testTypeId)
        {
            for (int i = 0; i < 500; i++)
            {
                Thread.Sleep(3000);
                var models = _humidityDataRealTimeDisplayService.GetWarningHumidityDatasBy(testTypeId).ToArray();
                Clients.All.RealTimeHumidityDatas(models);
            }
        }
    }
}