using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class CableForceDatasRealTimeMonitoringHub : Hub
    {
        ICableForceRealTimeDatasService _realTimeDatasService;

        public CableForceDatasRealTimeMonitoringHub()
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<ICableForceRealTimeDatasService>();

        }

        public void DisplayWarningCableForceDatas(int testTypeId)
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(testTypeId).ToArray();
            
            while (true)
            {
                var models = _realTimeDatasService.GetWarningCableForceDatasBy(sectionIds);
                Clients.All.RealTimeDisplayDatas(models);
                Thread.Sleep(10000);
                
            }
        }
    }
}
