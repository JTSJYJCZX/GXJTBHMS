using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

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

        public IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return _realTimeDatesTicker.GetInitDatas();
        }
    }
}
