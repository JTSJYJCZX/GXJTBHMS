using System;
using Microsoft.AspNet.SignalR;
using GxjtBHMS.Service.Interfaces.SafetyPreWarningRealTimePushServiceInterfaces;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using System.Threading;
using GxjtBHMS.DependencyInjection;
using GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService;

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
                var GetFirstLevelSafetyAssessmentReportListService = new GetFirstLevelSafetyAssessmentReportService();
                var LastReportTime = GetFirstLevelSafetyAssessmentReportListService.GetFirstSafetyAssessmentResult().FirstSafetyAssessmentReportTime_DateTime;
                var req = new GetSafetyWarningDetailRequest
                {
                    StartTime = LastReportTime,
                    EndTime = DateTime.Now
                };
                var model = _sfpwrtp.GetSafetyPreWarningRealTimePushModel(req);
                Clients.All.SafetyWarningStateRealTimePushDatas(model);
                Thread.Sleep(1000);
            }
        }
    }
}