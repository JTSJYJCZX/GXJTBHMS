using GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService;
using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.ServiceFactory;
using GxjtBHMS.Web.ViewModels.SafetyPreWarning;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers.SafetyPreWarning
{
    public class SafetyPreWarningController : Controller
    {
        public ActionResult SafetyPreWarning()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult GetSafetyWarningSearchContent()
        {
            var LastReportTime = GetLastReportTime_String();
            ViewData["LastReportTime"] = LastReportTime;
            return PartialView("GetSafetyWarningSearchContentPartial");
        }

        static String GetLastReportTime_String()
        {
            var GetFirstLevelSafetyAssessmentReportListService = new GetFirstLevelSafetyAssessmentReportService();
            var LastReportResult = GetFirstLevelSafetyAssessmentReportListService.GetFirstSafetyAssessmentResult();
            var LastReportTime = LastReportResult.FirstSafetyAssessmentReportTime;
            return LastReportTime;
        }

        public ActionResult GetSafetyWarningDetail(QuerySafetyPreWarningConditonView conditons)
        {
            int i = 0;
            var source = GetSafetyWarningDetailResultBy(conditons);  
            var resultView = new SafetyPreWarningModels();
            if (source.Succeed==true)
            {
                var models = new List<SafetyPreWarningViewModel>();
                foreach (var item in source.Datas)
                {
                    var resultItem = new SafetyPreWarningViewModel();
                    resultItem.Id = i + 1;
                    resultItem.PointsNumber = item.PointsNumber;
                    resultItem.Time = item.Time;
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
            else
            {
                return Content("<span style='color:red'>无记录</span>");
            }

        }

        private static SafetyWarningDetailResponse GetSafetyWarningDetailResultBy(QuerySafetyPreWarningConditonView conditons)
        {
            var GetFirstLevelSafetyAssessmentReportListService = new GetFirstLevelSafetyAssessmentReportService();
            var LastReportResult = GetFirstLevelSafetyAssessmentReportListService.GetFirstSafetyAssessmentResult();
            var LastReportTime = GetFirstLevelSafetyAssessmentReportListService.GetFirstSafetyAssessmentResult().FirstSafetyAssessmentReportTime_DateTime;
            var req = new GetSafetyWarningDetailRequest
            {
                StartTime = LastReportTime,
                EndTime = DateTime.Now
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