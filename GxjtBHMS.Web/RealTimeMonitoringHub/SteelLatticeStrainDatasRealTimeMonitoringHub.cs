using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class SteelLatticeStrainDatasRealTimeMonitoringHub : Hub
    {
        readonly SteelLatticeStrainDatasTicker _realTimeDatesTicker;
        public SteelLatticeStrainDatasRealTimeMonitoringHub() : this(SteelLatticeStrainDatasTicker.Instance){ }

        public SteelLatticeStrainDatasRealTimeMonitoringHub(SteelLatticeStrainDatasTicker rldt)
        {
            _realTimeDatesTicker = rldt;
        }
    }
}
