using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class WindLoadDatasRealTimeMonitoringHub : Hub
    {
        IWindLoadRealTimeDatasService _realTimeDatasService;

        public WindLoadDatasRealTimeMonitoringHub()
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<IWindLoadRealTimeDatasService>();

        }

        public void DisplayWarningWindLoadDatas(int testTypeId)
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(testTypeId).ToArray();
            
            while (true == true)
            {
                var models = _realTimeDatasService.GetWarningWindLoadDatasBy(sectionIds);
                Clients.All.RealTimeDisplayDatas(models);
                Thread.Sleep(5000);
            }
        }
    }
}
