using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class HumidityDatasRealTimeMonitoringHub : Hub
    {
        IHumidityRealTimeDatasService _realTimeDatasService;

        public HumidityDatasRealTimeMonitoringHub()
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<IHumidityRealTimeDatasService>();

        }

        public void DisplayWarningHumidityDatas(int testTypeId)
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(testTypeId).ToArray();
            
            while (true)
            {
                var models = _realTimeDatasService.GetWarningHumidityDatasBy(sectionIds);
                Clients.All.RealTimeDisplayDatas(models);
                Thread.Sleep(10000);
            }
        }
    }
}
