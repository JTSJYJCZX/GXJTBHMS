using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.SecondLevelSafetyAssessmentReport;
using GxjtBHMS.Service.SecondLevelSafetyAssessmentReportService;
using GxjtBHMS.Services.ViewModels;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.SafetyAssessmentReportView;
using GxjtBHMS.Web.ViewModels.SecondLevelSafetyAssessment;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GxjtBHMS.Web.Controllers
{
    public class SecondLevelSafetyAssessmentController : BaseController
    {
        IFileConverter _fileConverter;
        public SecondLevelSafetyAssessmentController(IFileConverter fileConverter)
        {
            _fileConverter = fileConverter;
        }

        [OutputCache(CacheProfile = "IndexProfile")]
        public ActionResult SecondLevelSafetyAssessment()
        {
            Response.Cache.SetOmitVaryStar(true);
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
            //获得状态等级的下拉菜单列表
            int firstGradeId;
            SaveSencondLevelAssessmentGradeSelectListItemsToViewData(out firstGradeId);
            var models = new SecondLevelSafetyAssessmentConditonViewModel()
            {
                wordFileSize = StyleConstants.wordFileSize,
            };
            return PartialView("GetReportListByTimeSearchPartial", models);
        }

        /// <summary>
        /// 获得状态等级的下拉菜单列表
        /// </summary>
        void SaveSencondLevelAssessmentGradeSelectListItemsToViewData(out int firstGradeId)
        {
            firstGradeId = 1;
            var GetSecondLevelSafetyAssessmentReportListService = new GetSecondLevelSafetyAssessmentReportService();
            var source = GetSecondLevelSafetyAssessmentReportListService.GetAllTestType();
            if (source.Any())
            {
                firstGradeId = Convert.ToInt32(source.First().Id);
            }
            var model = source.Select(m => new SelectListItemModel() { Id = m.Id, Name = m.AssessmentGrade });
            SaveSelectListItemCollectionToViewData(model, WebConstants.AssessmentStateKey, false);
        }

        /// <summary>
        /// 获得二级安全评估报告列表
        /// </summary>
        /// <param name="conditions"></param>
        /// <returns></returns>
        [OutputCache(CacheProfile = "SafetyAssessmentReportListProfile")]
        public ActionResult GetSecondLevelSafetyAssessmentReportList(SafetyAssessmentReportSearchBaseView conditions)
        {
            Response.Cache.SetOmitVaryStar(true);
            var req = new SecondLevelSafetyAssessmentSearchRequest()
            {
                CurrentPageIndex = conditions.CurrentPageIndex,
            };
            if (conditions.Time.Year != 1)
            {
                req.StartTime = new DateTime(conditions.Time.Year, conditions.Time.Month, 1);
                req.EndTime = req.StartTime.AddMonths(1);
            };
            var GetSecondLevelSafetyAssessmentReportListService = new GetSecondLevelSafetyAssessmentReportService();
            var resp = GetSecondLevelSafetyAssessmentReportListService.GetSecondLevelSafetyAssessmentReportList(req);
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
                    resultItem.AssessmentGrade = item.AssessmentResultState.AssessmentGrade;
                    resultItem.AssessmentState = item.AssessmentResultState.AssessmentState;
                    models.Add(resultItem);
                }
                resultView.SafetyAssessmentReportViewModels = models;
                resultView.PaginatorModel = new ViewModels.PaginatorModel { TotalPages = resp.TotalPages, CurrentPageIndex = conditions.CurrentPageIndex };
            }
            else
            {
                return Json(new { Color = StyleConstants.RedColor, message = resp.Message }, JsonRequestBehavior.AllowGet);
            }
            return PartialView("GetSecondLevelSafetyAssessmentListPartial", resultView);
        }

        /// <summary>
        /// 上传评估报告
        /// </summary>
        /// <param name="conditions"></param>
        /// <returns></returns>
        public ActionResult UploadSecondLevelSafetyAssessmentReport(int reportGradeId)
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
            var GetSecondLevelSafetyAssessmentReportListService = new GetSecondLevelSafetyAssessmentReportService();
            bool reportresp = GetSecondLevelSafetyAssessmentReportListService.GetReportNameIsNotHas(ReportName);
            if (reportresp == true)
            {
                files[0].SaveAs(ReprotPath); //保存文件
                DateTime uploadDate = DateTime.Now;
                var req = new SecondLevelSafetyAssementReportUploadRequest()
                {
                    ReportGradeId = reportGradeId,
                    ReportPath = ReprotPath,
                    uploadDate = uploadDate,
                    ReportName = ReportName,
                };
                var resp = GetSecondLevelSafetyAssessmentReportListService.UploadSecondlevelSafetyAssessmentReport(req);
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
        public ActionResult DownloadSecondLevelSafetyAssessmentReport(string ReportPath, string ReportName)
        {
            var req = new SecondLevelSafetyAssementReportUploadRequest()
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

        public ActionResult DeleteSecondLevelSafetyAssessmentReport(string ReportPath)
        {
            var req = new SecondLevelSafetyAssementReportUploadRequest()
            {
                ReportPath = ReportPath,
            };
            var GetSecondLevelSafetyAssessmentReportListService = new GetSecondLevelSafetyAssessmentReportService();
            var resp = GetSecondLevelSafetyAssessmentReportListService.DeleteSecondLevelSafetyAssessmentReport(req);
            if (resp.Succeed == true)
            {
                System.IO.File.Delete(ReportPath);
            }
            return Json(resp.Message, JsonRequestBehavior.AllowGet);
        }
    }
}