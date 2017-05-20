using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class TemperatureDatasRealTimeMonitoringHub : Hub
    {
        readonly TemperatureDatasTicker _realTimeDatesTicker;
        public TemperatureDatasRealTimeMonitoringHub() : this(TemperatureDatasTicker.Instance){ }

        public TemperatureDatasRealTimeMonitoringHub(TemperatureDatasTicker tdt)
        {
            _realTimeDatesTicker = tdt;
        }
    }
}
