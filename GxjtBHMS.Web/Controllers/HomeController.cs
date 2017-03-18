using System.Web.Mvc;
using GxjtBHMS.Web.Models;

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
            ViewBag.Message =   "我们是交通设计院";

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
    }
}