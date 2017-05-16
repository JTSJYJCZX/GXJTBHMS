using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class SteelArchStrainDatasRealTimeMonitoringHub : Hub
    {
        ISteelArchStrainRealTimeDatasService _realTimeDatasService;

        public SteelArchStrainDatasRealTimeMonitoringHub()
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<ISteelArchStrainRealTimeDatasService>();

        }

        public void DisplayWarningSteelArchStrainDatas(int testTypeId)
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
