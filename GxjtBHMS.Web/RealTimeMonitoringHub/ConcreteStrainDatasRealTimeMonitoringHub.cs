using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class ConcreteStrainDatasRealTimeMonitoringHub : Hub
    {
        readonly ConcreteStrainDatasTicker _realTimeDatesTicker;
        public ConcreteStrainDatasRealTimeMonitoringHub() : this(ConcreteStrainDatasTicker.Instance){ }

        public ConcreteStrainDatasRealTimeMonitoringHub(ConcreteStrainDatasTicker csdt)
        {
            _realTimeDatesTicker = csdt;
        }
    }
}
