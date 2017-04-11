using GxjtBHMS.Service.Messaging.SafetyPreWarning;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using GxjtBHMS.Service.ServiceFactory;
using NPOI.SS.Formula.Functions;
using System;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers.SafetyPreWarning
{
    public class SafetyPreWarningController : Controller
    {
        // GET: SafetyPreWarning
        public ActionResult SafetyPreWarning()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult GetSafetyWarningSearchContent()
        {
            //DateTime now = DateTime.Now;
            //var SearchRequestModel = new GetSafetyWarningDetailRequest
            //{
            //    StartTime = new DateTime(now.Year, now.Month, 1),
            //    EndTime = now
            //};

            return PartialView("GetSafetyWarningSearchContentPartial");
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