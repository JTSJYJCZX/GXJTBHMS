using GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.SafetyAssessmentReportView;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers.FirstLevelSafetyAssessment
{
    public class FirstLevelSafetyAssessmentController : Controller
    {

        public ActionResult FirstLevelSafetyAssessment()
        {
            var GetFirstLevelSafetyAssessmentReportListService = new GetFirstLevelSafetyAssessmentReportService();
            var resp = GetFirstLevelSafetyAssessmentReportListService.GetTotalPages();
            if (resp.Succeed)
            {
                ViewData["TotalPages"] = resp.TotalPages;
            }
            else
            {
                TempData[WebConstants.MessageColor] = StyleConstants.RedColor;
                TempData[WebConstants.Message] = resp.Message;
            }
            return View();
        }

        [ChildActionOnly]
        public ActionResult GetTimeSearchPartial()
        {
            return PartialView("GetTimeSearchPartial");
        }

        public ActionResult GetFirstLevelSafetyAssessmentReportList(SafetyAssessmentReportSearchBaseView conditions)
        {
            var req = new FirstLevelSafetyAssessmentSearchRequest()
            {
                CurrentPageIndex = conditions.CurrentPageIndex,
            };
            if (conditions.Time.Year!=1)
            {
               req.StartTime =new DateTime(conditions.Time.Year,conditions.Time.Month,1);
               req.EndTime = req.StartTime.AddMonths(1);
            };
            var GetFirstLevelSafetyAssessmentReportListService = new GetFirstLevelSafetyAssessmentReportService();
            var resp = GetFirstLevelSafetyAssessmentReportListService.GetFirstLevelSafetyAssessmentReportList(req);
            var models = new List<SafetyAssessmentReportViewModel>();
            var resultView = new SafetyAssessmentReportSearchBaseView();
            if (resp.Succeed)
            {
                foreach (var item in resp.FirstLevelSafetyAssessmentReport)
                {
                    var resultItem = new SafetyAssessmentReportViewModel();
                    resultItem.ReportName = item.ReportPeriods;
                    resultItem.ReportTime = item.ReportTime;
                    models.Add(resultItem);
                }
                resultView.SafetyAssessmentReportViewModels = models;
                resultView.PaginatorModel = new ViewModels.PaginatorModel { TotalPages = resp.TotalPages, CurrentPageIndex = conditions.CurrentPageIndex };            
            }
            else
            {
                return Json(new { Color = StyleConstants.RedColor, message = resp.Message }, JsonRequestBehavior.AllowGet);
            }
            return PartialView("GetFirstLevelSafetyAssessmentListPartial", resultView);
        }

        /// <summary>
        /// 下载评估报告
        /// </summary>
        /// <param name="conditions"></param>
        /// <returns></returns>
        public ActionResult DownloadFirstLevelSafetyAssessmentReport(SafetyAssessmentReportViewModel conditions)
        {


            return null;
        }


    }
}