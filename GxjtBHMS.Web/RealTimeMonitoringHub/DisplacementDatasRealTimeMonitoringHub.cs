using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;

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
            
            while (true)
            {
                var models = _realTimeDatasService.GetWarningDisplacementDatasBy(sectionIds);
                Clients.All.RealTimeDisplayDatas(models);
                Thread.Sleep(10000);
            }
        }
    }
}
