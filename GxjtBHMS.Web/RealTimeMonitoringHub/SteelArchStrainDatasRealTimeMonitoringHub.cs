using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class SteelArchStrainDatasRealTimeMonitoringHub : Hub
    {
        readonly SteelArchStrainDatasTicker _realTimeDatesTicker;
        public SteelArchStrainDatasRealTimeMonitoringHub() : this(SteelArchStrainDatasTicker.Instance){ }

        public SteelArchStrainDatasRealTimeMonitoringHub(SteelArchStrainDatasTicker rtdt)
        {
            _realTimeDatesTicker = rtdt;
        }
    }

}
