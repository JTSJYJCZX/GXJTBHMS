using GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.SafetyAssessmentReportView;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Implementations;
using GxjtBHMS.Service.Interfaces.FirstLevelAssessmInerfaces;

namespace GxjtBHMS.Web.Controllers.FirstLevelSafetyAssessment
{
    public class FirstLevelSafetyAssessmentController : Controller
    {
        IFileConverter _fileConverter;
        IFirstLevelAssessmReportDownloadFileInerfaces _reportDownloadFile;
        public FirstLevelSafetyAssessmentController(IFirstLevelAssessmReportDownloadFileInerfaces reportDownloadFile)
        {
            _reportDownloadFile = reportDownloadFile;
            _fileConverter = new WordFileConvert();
        }
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
            if (conditions.Time.Year != 1)
            {
                req.StartTime = new DateTime(conditions.Time.Year, conditions.Time.Month, 1);
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
                    resultItem.ReportId = item.Id;
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
        /// 报告下载，另存为Word文档
        /// </summary>
        /// <returns></returns>
        public ActionResult DownloadReport(int reportId)
        {
            //var report = new CreateReportTable();
            //var file = report.CreateTable(5);
            var file = _reportDownloadFile.GetDownloadDatas(reportId).Report;
            var guid = "";
            guid = Guid.NewGuid().ToString();
            CacheHelper.SetCache(guid, file);
            return Json(guid, JsonRequestBehavior.AllowGet);
        }

    }
}