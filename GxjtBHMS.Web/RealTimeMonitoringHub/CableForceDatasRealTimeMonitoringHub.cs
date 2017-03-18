using System.Linq;
using Microsoft.AspNet.SignalR;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using GxjtBHMS.Service.Interfaces;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class CableForceDatasRealTimeMonitoringHub : Hub
    {
        ICableForceDataRealTimeDisplayService _cableForceDataRealTimeDisplayService;

        public CableForceDatasRealTimeMonitoringHub()
        {
            _cableForceDataRealTimeDisplayService = new NinjectControllerFactory().GetInstance<ICableForceDataRealTimeDisplayService>();
        }



        public void DisplayWarningCableForceDatas(int testTypeId)
        {
            for (int i = 0; i < 500; i++)
            {
                Thread.Sleep(1000);
                var models = _cableForceDataRealTimeDisplayService.GetWarningCableForceDatasBy(testTypeId).ToArray();
                Clients.All.RealTimeDisplayDatas(models);
            }
        }
    }
}