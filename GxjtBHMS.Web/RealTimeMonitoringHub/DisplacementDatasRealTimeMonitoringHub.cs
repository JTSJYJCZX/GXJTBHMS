﻿using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System.Collections.Generic;

namespace GxjtBHMS.Web.RealTimeMonitoringHub
{
    public class DisplacementDatasRealTimeMonitoringHub : Hub
    {
        readonly DisplacementDatasTicker _realTimeDatesTicker;
        public DisplacementDatasRealTimeMonitoringHub() : this(DisplacementDatasTicker.Instance){ }

        public DisplacementDatasRealTimeMonitoringHub(DisplacementDatasTicker ddt)
        {
            _realTimeDatesTicker = ddt;
        }

        public IEnumerable<IncludeSectionWarningColorDataModel> GetInitDatas()
        {
            return _realTimeDatesTicker.GetInitDatas();
        }
    }
}
