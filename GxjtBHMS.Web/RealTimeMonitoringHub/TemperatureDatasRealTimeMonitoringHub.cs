using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;

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
            
            while (true)
            {
                var models = _realTimeDatasService.GetWarningTemperatureDatasBy(sectionIds);
                Clients.All.RealTimeDisplayDatas(models);
                Thread.Sleep(10000);
            }
        }
    }
}
