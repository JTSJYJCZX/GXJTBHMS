using GxjtBHMS.DependencyInjection;
using GxjtBHMS.Service.Interfaces;
using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Web.SafetyPreWarningHub
{
    public class SafetyPreWarningStateHub:Hub
    {
        ISteelArchStrainRealTimeDatasService _realTimeDatasService;

        public SafetyPreWarningStateHub()
        {
            _realTimeDatasService = new NinjectControllerFactory().GetInstance<ISteelArchStrainRealTimeDatasService>();
        }

        public void DisplayWarningSteelArchStrainDatas(int testTypeId)
        {
            var sectionIds = _realTimeDatasService.GetSectionIdsBy(testTypeId).ToArray();
            for (int i = 0; i < 100; i++)
            {
                //Thread.Sleep(1000);
                var models = _realTimeDatasService.GetWarningStrainDatasBy(sectionIds);
                Clients.All.RealTimeDisplayDatas(models);
            }
        }
    }
}