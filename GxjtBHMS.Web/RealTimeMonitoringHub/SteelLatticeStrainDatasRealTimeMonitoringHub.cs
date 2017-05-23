using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class SteelLatticeStrainDatasRealTimeMonitoringHub : Hub
    {
        readonly SteelLatticeStrainDatasTicker _realTimeDatesTicker;
        public SteelLatticeStrainDatasRealTimeMonitoringHub() : this(SteelLatticeStrainDatasTicker.Instance){ }

        public SteelLatticeStrainDatasRealTimeMonitoringHub(SteelLatticeStrainDatasTicker rldt)
        {
            _realTimeDatesTicker = rldt;
        }

        public IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return _realTimeDatesTicker.GetInitDatas();
        }
    }
}
