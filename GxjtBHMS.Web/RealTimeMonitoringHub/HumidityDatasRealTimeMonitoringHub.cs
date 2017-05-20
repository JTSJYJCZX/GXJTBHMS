using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class HumidityDatasRealTimeMonitoringHub : Hub
    {
        readonly HumidityDatasTicker _realTimeDatesTicker;
        public HumidityDatasRealTimeMonitoringHub() : this(HumidityDatasTicker.Instance){ }

        public HumidityDatasRealTimeMonitoringHub(HumidityDatasTicker hdr)
        {
            _realTimeDatesTicker = hdr;
        }
    }
}
