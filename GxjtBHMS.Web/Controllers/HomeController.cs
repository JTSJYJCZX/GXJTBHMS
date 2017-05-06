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
                FirstSafetyAssessmentReportTime = FirstSafetyAssessmentResult.FirstSafetyAssessmentReportTime,
                SecondSafetyAssessmentResult = SecondLevelSafetyAssessmentResult.SecondSafetyAssessmentResult,
                SecondSafetyAssessmentReportTime = SecondLevelSafetyAssessmentResult.SecondSafetyAssessmentReportTime,
                ManualInspectionSafetyAssessmentResult = ManualInspectionSafetyAssessmentResult.ManualInspectionSafetyAssessmentResult,
                ManualInspectionSafetyAssessmentReportTime = ManualInspectionSafetyAssessmentResult.ManualInspectionSafetyAssessmentReportTime


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
            var FirstSafetyAssessmentSuggestion = GetAssessmentSuggestion.GetFirstSafetyAssessmentSuggestion();
            var model = new SafetyAssessmentSuggestionModelsViewModel()
            {
                FirstSafetyAssessmentSuggestion_CableForce = FirstSafetyAssessmentSuggestion.FirstSafetyAssessmentSuggestion_CableForce,
                FirstSafetyAssessmentSuggestion_Displacement = FirstSafetyAssessmentSuggestion.FirstSafetyAssessmentSuggestion_Displacement,
                FirstSafetyAssessmentSuggestion_Stress = FirstSafetyAssessmentSuggestion.FirstSafetyAssessmentSuggestion_Stress,

            };
            return PartialView("GetSafetyAssessmentSuggestion", model);

        }

        /// <summary>
        /// 获得当天各个测试类型异常事件的数量
        /// </summary>
        /// <returns></returns>
        public ActionResult GetAbnormalEventNumber()
        {
            //var GetAbnormalEventNumber = new AnomalousEventManagementQueryServiceBase();
            //var AbnormalEventNumber = GetAbnormalEventNumber.GetAllAbnormalEventNumber();
            //var model = new AbnormalEventNumberViewModel()
            //{
            //    AbnormalEventNumber_CableForces=


            //};
 
            return PartialView("GetAbnormalEventNumberPartial");
        }





    }
}