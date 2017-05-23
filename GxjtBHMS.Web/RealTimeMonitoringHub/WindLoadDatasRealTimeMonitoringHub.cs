using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

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

        public IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return _realTimeDatesTicker.GetInitDatas();
        }
    }
}
