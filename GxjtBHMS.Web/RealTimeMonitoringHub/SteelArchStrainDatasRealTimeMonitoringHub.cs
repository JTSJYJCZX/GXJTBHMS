using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

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

        public IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return _realTimeDatesTicker.GetInitDatas();
        }

    }

    

}
