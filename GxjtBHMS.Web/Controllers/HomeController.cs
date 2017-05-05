using System.Web.Mvc;
using GxjtBHMS.Web.Models;
using GxjtBHMS.Web.ViewModels.Home;
using GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService;
using GxjtBHMS.Service.SecondLevelSafetyAssessmentReportService;
using GxjtBHMS.Service.ManualInspectionSafetyAssessmentReportService;

namespace GxjtBHMS.Web.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewData[WebConstants.UserNickNameKey] = Session[WebConstants.UserNickNameKey].ToString();
            return View();
        }


        public ActionResult About()
        {
            ViewBag.Message = "我们是交通设计院";

            return View();
        }

        /// <summary>
        /// 仅仅做推送数据测试
        /// </summary>
        /// <returns></returns>
        public ActionResult StrainDataPushing()
        {
            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        /// <summary>
        /// 获得安全预警的内容
        /// </summary>
        /// <returns></returns>
        [ChildActionOnly]
        public ActionResult GetSafetyWarningSearchContent()
        {
            return PartialView("GetSafetyWarningContentPartial");
        }

        /// <summary>
        /// 获得状态评估结果的列表
        /// </summary>
        /// <returns></returns>
        [ChildActionOnly]
        public ActionResult GetSafetyAssessmentResult()
        {
            //查询一级安全评估结果

            var GetFirstSafetyAssessmentResult = new GetFirstLevelSafetyAssessmentReportService();
            var FirstSafetyAssessmentResult = GetFirstSafetyAssessmentResult.GetFirstSafetyAssessmentResult();
            var GetSecondLevelSafetyAssessmentResult = new GetSecondLevelSafetyAssessmentReportService();
            var SecondLevelSafetyAssessmentResult = GetSecondLevelSafetyAssessmentResult.GetSecondLevelSafetyAssessmentResult();
            var GetManualInspectionSafetyAssessmentResult = new GetManualInspectionSafetyAssessmentReportService();
            var ManualInspectionSafetyAssessmentResult = GetManualInspectionSafetyAssessmentResult.GetManualInspectionSafetyAssessmentReportResult();

            var model = new SafetyAssessmentModelsViewModel()
            {
                FirstSafetyAssessmentResult_CableForce = FirstSafetyAssessmentResult.FirstSafetyAssessmentResult_CableForce,
                FirstSafetyAssessmentResult_Displacement = FirstSafetyAssessmentResult.FirstSafetyAssessmentResult_Displacement,
                FirstSafetyAssessmentResult_Stress = FirstSafetyAssessmentResult.FirstSafetyAssessmentResult_Stress,
                SecondSafetyAssessmentResult =SecondLevelSafetyAssessmentResult.SecondSafetyAssessmentResult,
                ManualInspectionSafetyAssessmentResult = ManualInspectionSafetyAssessmentResult.ManualInspectionSafetyAssessmentResult

            };
            return PartialView("GetSafetyAssessmentResult", model);

        }
        /// <summary>
        /// 获得工作建议的列表
        /// </summary>
        /// <returns></returns>

        [ChildActionOnly]
        public ActionResult GetAssessmentSuggestion()
        {
            //查询工作建议结果
            var GetAssessmentSuggestion = new GetFirstLevelSafetyAssessmentReportService();
            var FirstSafetyAssessmentSuggestion= GetAssessmentSuggestion.GetFirstSafetyAssessmentSuggestion();
            var model = new SafetyAssessmentSuggestionModelsViewModel()
            {
                FirstSafetyAssessmentSuggestion_CableForce = FirstSafetyAssessmentSuggestion.FirstSafetyAssessmentSuggestion_CableForce,
                FirstSafetyAssessmentSuggestion_Displacement = FirstSafetyAssessmentSuggestion.FirstSafetyAssessmentSuggestion_Displacement,
                FirstSafetyAssessmentSuggestion_Stress = FirstSafetyAssessmentSuggestion.FirstSafetyAssessmentSuggestion_Stress,
              
            };
            return PartialView("GetSafetyAssessmentSuggestion", model);

        }





    }
}