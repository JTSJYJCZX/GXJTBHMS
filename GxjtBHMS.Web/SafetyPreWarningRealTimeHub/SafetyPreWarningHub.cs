using System;
using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using System.Threading;
using GxjtBHMS.DependencyInjection;

namespace GxjtBHMS.Web.SafetyPreWarningRealTimeHub
{
    public class SafetyPreWarningHub : Hub
    {
        ISafetyPreWarningRealTimePushService _sfpwrtp;
        public SafetyPreWarningHub()
        {
            _sfpwrtp = new NinjectControllerFactory().GetInstance<ISafetyPreWarningRealTimePushService>();
        }
        public void BridgeSafetyPreWarningStateDisplay()
        {
            while (true)
            {
                DateTime now = DateTime.Now;
                var req = new GetSafetyWarningDetailRequest
                {
                    StartTime = new DateTime(now.Year, now.Month, 1),
                    EndTime = now,
            };
                var model = _sfpwrtp.GetSafetyPreWarningRealTimePushModel(req);
                Clients.All.SafetyWarningStateRealTimePushDatas(model);
                Thread.Sleep(1000);
            }
        }
    }
}