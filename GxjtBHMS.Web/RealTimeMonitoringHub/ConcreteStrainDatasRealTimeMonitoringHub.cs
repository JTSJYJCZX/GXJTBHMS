using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

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

        public IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return _realTimeDatesTicker.GetInitDatas();
        }
    }
}
