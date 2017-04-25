using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.SecondLevelSafetyAssessmentReportService;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.FirstLevelSafetyAssessment;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    public class SecondLevelSafetyAssessmentController : Controller
    {

        public ActionResult SecondLevelSafetyAssessment()
        {
            var GetSecondLevelSafetyAssessmentReportListService = new GetSecondLevelSafetyAssessmentReportService();
            var resp = GetSecondLevelSafetyAssessmentReportListService.GetTotalPages();
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
        public ActionResult GetReportListByTimeSearchPartial()
        {
            return PartialView("GetReportListByTimeSearchPartial");
        }


        public ActionResult GetSecondLevelSafetyAssessmentReportList(FirstLevelSafetyAssessmentSearchBarBaseView conditions)
        {
            var req = new SecondLevelSafetyAssessmentSearchRequest()
            {
                CurrentPageIndex = conditions.CurrentPageIndex,
            };
            if (conditions.Time.Year!=1)
            {
               req.StartTime =new DateTime(conditions.Time.Year,conditions.Time.Month,1);
               req.EndTime = req.StartTime.AddMonths(1);
            };
            var GetSecondLevelSafetyAssessmentReportListService = new GetSecondLevelSafetyAssessmentReportService();
            var resp = GetSecondLevelSafetyAssessmentReportListService.GetFirstLevelSafetyAssessmentReportList(req);
            var models = new List<FirstLevelSafetyAssessmentViewModel>();
            var resultView = new FirstLevelSafetyAssessmentSearchBarBaseView();
            if (resp.Succeed)
            {
                foreach (var item in resp.SecondLevelSafetyAssessmentReport)
                {
                    var resultItem = new FirstLevelSafetyAssessmentViewModel();
                    resultItem.ReportName = item.ReportPeriods;
                    resultItem.ReportTime = item.ReportTime;
                    resultItem.AssessmentGrade = item.AssessmentResultState.AssessmentGrade;
                    resultItem.AssessmentState = item.AssessmentResultState.AssessmentState;
                    models.Add(resultItem);
                }
                resultView.FirstLevelSafetyAssessmentViewModels = models;
                resultView.PaginatorModel = new ViewModels.PaginatorModel { TotalPages = resp.TotalPages, CurrentPageIndex = conditions.CurrentPageIndex };            
            }
            else
            {
                return Json(new { Color = StyleConstants.RedColor, message = resp.Message }, JsonRequestBehavior.AllowGet);
            }
            return PartialView("GetSecondLevelSafetyAssessmentListPartial", resultView);
        }

        /// <summary>
        /// 下载评估报告
        /// </summary>
        /// <param name="conditions"></param>
        /// <returns></returns>
        public ActionResult DownloadFirstLevelSafetyAssessmentReport(FirstLevelSafetyAssessmentViewModel conditions)
        {


            return null;
        }


    }
}