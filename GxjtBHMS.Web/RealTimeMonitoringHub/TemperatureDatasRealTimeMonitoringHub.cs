using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using GxjtBHMS.Service.Interfaces;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class TemperatureDatasRealTimeMonitoringHub : Hub
    {
        ITemperatureDataRealTimeDisplayService _temperatureDataRealTimeDisplayService;

        public TemperatureDatasRealTimeMonitoringHub()
        {
            _temperatureDataRealTimeDisplayService = new NinjectControllerFactory().GetInstance<ITemperatureDataRealTimeDisplayService>();
        }



        public void DisplayWarningTemperatureDatas(int testTypeId)
        {
            for (int i = 0; i < 500; i++)
            {
                Thread.Sleep(1000);
                var models = _temperatureDataRealTimeDisplayService.GetWarningTemperatureDatasBy(testTypeId).ToArray();
                Clients.All.RealTimeTemperatureDatas(models);
            }
        }
    }
}