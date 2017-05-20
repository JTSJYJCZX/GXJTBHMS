using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using System.Linq;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class SteelLatticeStrainDatasRealTimeMonitoringHub : Hub
    {
        ISteelLatticeStrainRealTimeDatasService _realTimeDatasService;

        public SteelLatticeStrainDatasRealTimeMonitoringHub()
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<ISteelLatticeStrainRealTimeDatasService>();

        }

        //public void DisplayWarningSteelLatticeStrainDatas(int testTypeId)
        //{
        //    var sectionIds = _realTimeDatasService.GetSectionIdsBy(testTypeId).ToArray();
            
        //    while (true)
        //    {
        //        var models = _realTimeDatasService.GetWarningStrainDatasBy(sectionIds);
        //        Clients.All.RealTimeDisplayDatas(models);
        //        Thread.Sleep(10000);
        //    }
        //}
    }
}
