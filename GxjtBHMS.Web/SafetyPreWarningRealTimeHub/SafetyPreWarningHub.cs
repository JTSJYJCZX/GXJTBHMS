using Microsoft.AspNet.SignalR;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Service.ViewModels.SafetyPreWarning;

namespace GxjtBHMS.Web.SafetyPreWarningRealTimeHub
{
    public class SafetyPreWarningHub : Hub
    {
        readonly SafetyPreWarningTicker _realTimeDatesTicker;
        public SafetyPreWarningHub() : this(SafetyPreWarningTicker.Instance){ }

        public SafetyPreWarningHub(SafetyPreWarningTicker spwt)
        {
            _realTimeDatesTicker = spwt;
        }

        public AllSafetyPreWarningStateDataModel GetInitDatas()
        {
            return _realTimeDatesTicker.GetInitDatas();
        }
    }
}