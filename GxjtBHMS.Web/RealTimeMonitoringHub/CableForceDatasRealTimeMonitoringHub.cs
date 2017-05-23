using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

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

        public IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return _realTimeDatesTicker.GetInitDatas();
        }
    }
}
