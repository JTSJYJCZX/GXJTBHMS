using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class StrainDatasRealTimeMonitoringHub : Hub
    {
        IStrainDataRealTimeDisplayService _strainDataDisplayService;

        public StrainDatasRealTimeMonitoringHub()
        {
            _strainDataDisplayService = new NinjectControllerFactory().GetInstance<IStrainDataRealTimeDisplayService>();
           
        }

        public void DisplayWarningStrainDatas(int testTypeId)
        {
            for (int i = 0; i < 100; i++)
            {
                //Thread.Sleep(1000);
                var models = _strainDataDisplayService.GetWarningStrainDatasBy(testTypeId).ToArray();
                Clients.All.RealTimeDisplayDatas(models);
            }
        }

    }
}