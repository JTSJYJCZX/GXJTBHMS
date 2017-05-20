using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class WindLoadDatasRealTimeMonitoringHub : Hub
    {
        readonly WindLoadDatasTicker _realTimeDatesTicker;
        public WindLoadDatasRealTimeMonitoringHub() : this(WindLoadDatasTicker.Instance){ }

        public WindLoadDatasRealTimeMonitoringHub(WindLoadDatasTicker wdt)
        {
            _realTimeDatesTicker = wdt;
        }
    }
}
