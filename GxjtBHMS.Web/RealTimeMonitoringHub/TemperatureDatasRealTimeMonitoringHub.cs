using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class TemperatureDatasRealTimeMonitoringHub : Hub
    {
        ITemperatureRealTimeDatasService _realTimeDatasService;

        public TemperatureDatasRealTimeMonitoringHub()
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<ITemperatureRealTimeDatasService>();

        }

        public void DisplayWarningTemperatureDatas(int testTypeId)
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(testTypeId).ToArray();
            
            while (true == true)
            {
                var models = _realTimeDatasService.GetWarningTemperatureDatasBy(sectionIds);
                Clients.All.RealTimeDisplayDatas(models);
                Thread.Sleep(5000);
            }
        }
    }
}
