using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

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

        public IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return _realTimeDatesTicker.GetInitDatas();
        }
    }
}
