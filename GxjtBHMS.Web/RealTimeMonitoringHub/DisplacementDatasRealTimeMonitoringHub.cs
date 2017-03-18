using System.Linq;
using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.DependencyInjection;
using System.Threading;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class DisplacementDatasRealTimeMonitoringHub : Hub
    {
        IDisplaymentDataRealTimeDisplayService _displaymentDataRealTimeDisplayService;

        public DisplacementDatasRealTimeMonitoringHub()
        {
            _displaymentDataRealTimeDisplayService = new NinjectControllerFactory().GetInstance<IDisplaymentDataRealTimeDisplayService>();
        }

        public void DisplayWarningDisplaymentDatas(int testTypeId)
        {
            for (int i = 0; i < 500; i++)
            {
                Thread.Sleep(1000);
                var models = _displaymentDataRealTimeDisplayService.GetWarningDisplaymentDatasBy(testTypeId).ToArray();
                Clients.All.RealTimeDisplayDatas(models);
            }
        }



    }
}