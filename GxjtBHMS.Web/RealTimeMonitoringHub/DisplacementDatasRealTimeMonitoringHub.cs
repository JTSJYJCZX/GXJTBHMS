using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class DisplacementDatasRealTimeMonitoringHub : Hub
    {
        readonly DisplacementDatasTicker _realTimeDatesTicker;
        public DisplacementDatasRealTimeMonitoringHub() : this(DisplacementDatasTicker.Instance){ }

        public DisplacementDatasRealTimeMonitoringHub(DisplacementDatasTicker ddt)
        {
            _realTimeDatesTicker = ddt;
        }
    }
}
