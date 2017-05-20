using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class SteelArchStrainDatasRealTimeMonitoringHub : Hub
    {
        readonly RealTimeDatesTicker _realTimeDatesTicker;
        public SteelArchStrainDatasRealTimeMonitoringHub() : this(RealTimeDatesTicker.Instance){ }

        public SteelArchStrainDatasRealTimeMonitoringHub(RealTimeDatesTicker rtdt)
        {
            _realTimeDatesTicker = rtdt;
        }
    }

}
