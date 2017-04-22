using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ServiceFactory;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.SafetyPreWarning;
using GxjtBHMS.Web.ViewModels.SafetyPreWarning;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers.FirstLevelSafetyAssessment
{
    public class FirstLevelSafetyAssessmentController : Controller
    {
        public ActionResult FirstLevelSafetyAssessment()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult GetFirstLevelSafetyAssessmentContent()
        {
            return PartialView("GetFirstLevelSafetyAssessmentContentPartial");
        }













        public ActionResult GetSafetyWarningDetail(QuerySafetyPreWarningConditonView conditons)
        {
            int i = 0;
            var resultCondition = GetSafetyWarningDetailResultBy(conditons);
            var resultView = new SafetyPreWarningModels();
            var models = new List<SafetyPreWarningViewModel>();          
            foreach (var item in resultCondition)
            {               
                var resultItem = new SafetyPreWarningViewModel();
                resultItem.Id = i+1;
                resultItem.PointsNumber = item.PointsNumber;
                resultItem.Time=item.Time;
                resultItem.MonitoringData = item.MonitoringData;
                resultItem.Unit = item.Unit;
                resultItem.ThresholdValue = item.ThresholdValue;
                resultItem.SafetyPreWarningState = item.SafetyPreWarningState;
                resultItem.Suggestion = item.Suggestion;
                models.Add(resultItem);
                i++;
            }
            resultView.SafetyPreWarnings = models;
            return PartialView("SafetyPreWarningDetailListPartial", resultView);
        }

        private static IEnumerable<SafetyPreWarningDetailQueryModel> GetSafetyWarningDetailResultBy(QuerySafetyPreWarningConditonView conditons)
        {
            DateTime now = DateTime.Now;
            var req = new GetSafetyWarningDetailRequest
            {
                StartTime = new DateTime(now.Year, now.Month, 1),
                EndTime = now
            };
            var SafetyWarningDetailQueryService = SafetyWarningDetailFactory.GetSafetyWarningDetailServiceFrom(conditons.testTypeId);
            return SafetyWarningDetailQueryService.GetSafetyPreWarningDetailBy(req);
        }

        public ActionResult DisplaySafetyPreWarningStateAndTotalTimesby()
        {

            return View();
        }
    }
}