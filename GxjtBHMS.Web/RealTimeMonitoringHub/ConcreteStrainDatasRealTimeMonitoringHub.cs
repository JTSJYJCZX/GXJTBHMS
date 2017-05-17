using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class ConcreteStrainDatasRealTimeMonitoringHub : Hub
    {
        IConcreteStrainRealTimeDatasService _realTimeDatasService;

        public ConcreteStrainDatasRealTimeMonitoringHub()
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<IConcreteStrainRealTimeDatasService>();

        }

        public void DisplayWarningConcreteStrainDatas(int testTypeId)
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(testTypeId).ToArray();
            
            while (true)
            {
                var models = _realTimeDatasService.GetWarningStrainDatasBy(sectionIds);
                Clients.All.RealTimeDisplayDatas(models);
                Thread.Sleep(10000);
            }
        }
    }
}
