using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class CableForceDatasRealTimeMonitoringHub : Hub
    {
        readonly CableForceDatasTicker _realTimeDatesTicker;
        public CableForceDatasRealTimeMonitoringHub() : this(CableForceDatasTicker.Instance){ }

        public CableForceDatasRealTimeMonitoringHub(CableForceDatasTicker cfdt)
        {
            _realTimeDatesTicker = cfdt;
        }
    }
}
