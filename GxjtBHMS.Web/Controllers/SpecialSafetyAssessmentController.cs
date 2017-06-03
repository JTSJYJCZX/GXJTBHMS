using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.SpecialSafetyAssessmentReport;
using GxjtBHMS.Service.SpecialSafetyAssessmentReportService;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.SafetyAssessmentReportView;
using GxjtBHMS.Web.ViewModels.SpecialSafetyAssessment;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    public class SpecialSafetyAssessmentController : BaseController
    {
        IFileConverter _fileConverter;
        public SpecialSafetyAssessmentController(IFileConverter fileConverter)
        {
            _fileConverter = fileConverter;
        }

        [OutputCache(CacheProfile = "IndexProfile")]
        public ActionResult SpecialSafetyAssessment()
        {
            Response.Cache.SetOmitVaryStar(true);
            var _getSpecialSafetyAssessmentReportService = new GetSpecialSafetyAssessmentReportService();
            var resp = _getSpecialSafetyAssessmentReportService.GetTotalPages();
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
        public ActionResult GetSpecialReportListByTimeSearchPartial()
        {
            var models = new SpecialSafetyAssessmentConditonViewModel()
            {
                wordFileSize = StyleConstants.wordFileSize,
            };
            return PartialView("GetSpecialReportListByTimeSearchPartial", models);
        }

        /// <summary>
        /// 获得专项安全评估报告列表
        /// </summary>
        /// <param name="conditions"></param>
        /// <returns></returns>
        [OutputCache(CacheProfile = "SafetyAssessmentReportListProfile")]
        public ActionResult GetSpecialSafetyAssessmentReportList(SafetyAssessmentReportSearchBaseView conditions)
        {
            Response.Cache.SetOmitVaryStar(true);
            var req = new SpecialSafetyAssessmentSearchRequest()
            {
                CurrentPageIndex = conditions.CurrentPageIndex,
            };
            if (conditions.Time.Year != 1)
            {
                req.StartTime = new DateTime(conditions.Time.Year, conditions.Time.Month, 1);
                req.EndTime = req.StartTime.AddMonths(1);
            };
            var _getSpecialSafetyAssessmentReportService = new GetSpecialSafetyAssessmentReportService();
            var resp = _getSpecialSafetyAssessmentReportService.GetSpecialSafetyAssessmentReportList(req);
            var models = new List<SafetyAssessmentReportViewModel>();
            var resultView = new SafetyAssessmentReportSearchBaseView();
            if (resp.Succeed)
            {
                foreach (var item in resp.SecondLevelSafetyAssessmentReport)
                {
                    var resultItem = new SafetyAssessmentReportViewModel();
                    resultItem.ReportName = item.ReportPeriods;
                    resultItem.ReporePath = item.ReprotPath;
                    resultItem.ReportTime = DateTimeHelper.FormatDateTime(item.ReportTime);
                    models.Add(resultItem);
                }
                resultView.SafetyAssessmentReportViewModels = models;
                resultView.PaginatorModel = new ViewModels.PaginatorModel { TotalPages = resp.TotalPages, CurrentPageIndex = conditions.CurrentPageIndex };
            }
            else
            {
                return Json(new { Color = StyleConstants.RedColor, message = resp.Message }, JsonRequestBehavior.AllowGet);
            }
            return PartialView("GetSpecialSafetyAssessmentListPartial", resultView);
        }

        /// <summary>
        /// 上传专项评估报告
        /// </summary>
        /// <param name="conditions"></param>
        /// <returns></returns>
        public ActionResult UploadSpecialSafetyAssessmentReport()
        {
            HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;
            if (files.Count == 0)
            {
                return Json("未选择文件！", JsonRequestBehavior.AllowGet);
            }
            HttpPostedFile fileSave = files[0];//转换文件类型
            string ReportName = fileSave.FileName; //获得服务端上传文件的文件名
            string path = System.Web.HttpContext.Current.Server.MapPath(StyleConstants.SecondLevelSafetyAssessmentReportUploasPath);
            string ReprotPath = string.Concat(path, ReportName);//拼接上传文件的保存路径
            var _getSpecialSafetyAssessmentReportService = new GetSpecialSafetyAssessmentReportService();
            bool reportresp = _getSpecialSafetyAssessmentReportService.GetReportNameIsNotHas(ReportName);
            if (reportresp == true)
            {
                files[0].SaveAs(ReprotPath); //保存文件
                DateTime uploadDate = DateTime.Now;
                var req = new SpecialSafetyAssementReportUploadRequest()
                {
                    ReportPath = ReprotPath,
                    uploadDate = uploadDate,
                    ReportName = ReportName,
                };
                var resp = _getSpecialSafetyAssessmentReportService.UploadSpecialSafetyAssessmentReport(req);
                return Json(resp.Message, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json("该文件名已存在，请重新选择文件或重命名上传文件！", JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// 下载报告
        /// </summary>
        /// <param name="ReportPath">本地上传报告的路径</param>
        /// <param name="ReportName">报告名字</param>
        /// <returns></returns>
        public ActionResult DownloadSpecialSafetyAssessmentReport(string ReportPath, string ReportName)
        {
            var req = new SpecialSafetyAssementReportUploadRequest()
            {
                ReportPath = ReportPath,
                ReportName = ReportName
            };
            FileStream fileStream = new FileStream(ReportPath, FileMode.Open);
            var guid = "";
            guid = Guid.NewGuid().ToString();
            CacheHelper.SetCache(guid, fileStream);
            return Json(guid, JsonRequestBehavior.AllowGet);
        }


        /// <summary>
        /// 自定义下载文档的路径
        /// </summary>
        /// <param name="guid">文件流</param>
        /// <param name="ReportName">报告名字</param>
        public void OriginCode(string guid, string ReportName)
        {
            object obj = CacheHelper.GetCache(guid);
            if (obj == null)
            {
                throw new ApplicationException("guid invalid");
            }
            FileStream bs = obj as FileStream;
            byte[] bytes = new byte[(int)bs.Length];
            bs.Read(bytes, 0, bytes.Length);
            bs.Close();
            Response.AddHeader("Content-Disposition", string.Format("attachment; filename={0}", ReportName));
            Response.ContentType = "application/ms-word";
            Response.Charset = "utf-8";
            Response.BinaryWrite(bytes);
            Response.Flush();
            Response.End();
            Response.Close();
        }

        public ActionResult DeleteSpecialSafetyAssessmentReport(string ReportPath)
        {
            var req = new SpecialSafetyAssementReportUploadRequest()
            {
                ReportPath = ReportPath,
            };

            var _getSpecialSafetyAssessmentReportService = new GetSpecialSafetyAssessmentReportService();
            var resp = _getSpecialSafetyAssessmentReportService.DeleteSpecialSafetyAssessmentReport(req);
            if (resp.Succeed == true)
            {
                System.IO.File.Delete(ReportPath);
            }
            return Json(resp.Message, JsonRequestBehavior.AllowGet);
        }
    }
}