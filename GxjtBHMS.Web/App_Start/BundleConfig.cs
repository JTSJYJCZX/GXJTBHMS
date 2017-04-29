using System.Web.Optimization;

namespace GxjtBHMS.Web
{
    public static class BundleConfig
    {
        // 有关绑定的详细信息，请访问 http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));
            //jquery-ui include js and css begin
            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                        "~/Scripts/jquery-ui-{version}.min.js"));

            bundles.Add(new StyleBundle("~/content/css/jqueryui").Include("~/Content/themes/base/jquery-ui.min.css"));
            //jquery-ui end

            // 使用要用于开发和学习的 Modernizr 的开发版本。然后，当你做好
            // 生产准备时，请使用 http://modernizr.com 上的生成工具来仅选择所需的测试。
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                    "~/Scripts/bootstrap.js",
                    "~/Scripts/respond.js"));

            //bootstrap-select js css
            bundles.Add(new ScriptBundle("~/bundles/bootstrap-select").Include(
                      "~/Scripts/bootstrap-select.min.js"));
            bundles.Add(new StyleBundle("~/content/css/bootstrap-select").Include(
                  "~/Content/bootstrap-select.min.css"));
            bundles.Add(new ScriptBundle("~/bundles/listThresholdValueMessage-website").Include(
                         "~/Scripts/thresholdValueSetting/listThresholdValueMessage-website.js"));
            //jqPlot图表插件脚本和样式
            bundles.Add(new ScriptBundle("~/bundles/jqplot").Include("~/Scripts/jqPlot/jquery.jqplot.js"));
            bundles.Add(new ScriptBundle("~/bundles/jqplot/plugins").Include(
                 "~/Scripts/jqPlot/plugins/jqplot.dateAxisRenderer.min.js",
                 "~/Scripts/jqPlot/plugins/jqplot.barRenderer.min.js",
                  "~/Scripts/jqPlot/plugins/jqplot.categoryAxisRenderer.min.js",
                  "~/Scripts/jqPlot/plugins/jqplot.cursor.min.js",
                  "~/Scripts/jqPlot/plugins/jqplot.highlighter.min.js",
                  "~/Scripts/jqPlot/plugins/jqplot.canvasTextRenderer.min.js",
                  "~/Scripts/jqPlot/plugins/jqplot.categoryAxisRenderer.min", 
                  "~/Scripts/jqPlot/plugins/jqplot.canvasAxisLabelRenderer.min.js",
                  "~/Scripts/jqPlot/plugins/jqplot.canvasAxisTickRenderer.min.js",
                  "~/Scripts/jqPlot/plugins/jqplot.jqplot.pointLabels.min.js",
                  "~/Scripts/jqPlot/excanvas.min.js",
                   "~/Scripts/jqPlot/plugins/jqplot.enhancedLegendRenderer.min.js"
                  ));
            bundles.Add(new StyleBundle("~/content/jqplotcss").Include("~/Scripts/jqPlot/jquery.jqplot.min.css"));

            bundles.Add(new StyleBundle("~/content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css",
                      "~/Content/system.css"));
          

            //通用日期时间插件脚本和样式
            bundles.Add(new ScriptBundle("~/bundles/datetimepicker").Include(
                  "~/Scripts/jquery.datetimepicker.js").Include("~/Scripts/jquery.datetimepicker.launcher.js"));

            bundles.Add(new StyleBundle("~/content/datetimepickercss").Include("~/Content/jquery.datetimepicker.css"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryunobtrusiveajax").Include(
                "~/Scripts/jquery.unobtrusive-ajax.min.js"));


            bundles.Add(new ScriptBundle("~/bundles/jqPaginator")
                .Include(
    "~/Scripts/jqPaginator.min.js")
    .Include("~/Scripts/jqPaginator.launcher.js"));
            //遮罩
            bundles.Add(new ScriptBundle("~/bundles/mask/chardinjs").Include("~/Scripts/chardinjs.min.js"));
            bundles.Add(new StyleBundle("~/content/mask/chardinjs").Include("~/Content/chardinjs.css"));

            //SigalR+hubs js 
            bundles.Add(new ScriptBundle("~/bundles/sigalR")
                .Include("~/Scripts/jquery.signalR-{version}.js"));

            //htmlencode js
            bundles.Add(new ScriptBundle("~/bundles/htmlencode")
                .Include("~/Scripts/htmlencode.js"));

            //监测数据查询搜索栏脚本
            bundles.Add(new ScriptBundle("~/bundles/monitoringDatasSearchBar").Include(
                     "~/Scripts/dataQuerySearchPartial.website.js"));

            //监测数据对比查询搜索栏脚本
            bundles.Add(new ScriptBundle("~/bundles/monitoringDatasComparingSearchBar").Include(
                     "~/Scripts/dataComparingQuerySearchPartial.website.js"));

            //ListUserMessage视图的脚本
            bundles.Add(new ScriptBundle("~/bundles/listUserMessage-website").Include(
                   "~/Scripts/adminUser/listUserMessage-website.js"));
            //热点插件脚本和样式
            bundles.Add(new ScriptBundle("~/bundles/hotspot").Include(
                  "~/Scripts/jquery.hotspot.min.js"));
            bundles.Add(new StyleBundle("~/content/hotspotcss").Include("~/Content/jquery.hotspot.css"));

            //系统通用脚本
            bundles.Add(new ScriptBundle("~/bundles/system").Include(
                "~/Scripts/system.js"));

            //阈值设置下拉菜单搜索栏脚本
            bundles.Add(new ScriptBundle("~/bundles/thresholdValueSearchBar").Include(
                     "~/Scripts/thresholdValueSetting/ThresholdValueSearchPartial.website.js"));

            //异常阈值保存脚本
            bundles.Add(new ScriptBundle("~/bundles/AbnormalThresholdValueSetting").Include(
                     "~/Scripts/AbnormalThresholdValueSetting/listAbnormalThresholdValueMessage-website.js"));


            //安全阈值详情查询脚本
            bundles.Add(new ScriptBundle("~/bundles/SafetyPreWarningDetailSearchPartialwebsite").Include(
                     "~/Scripts/SafetyPreWarningDetail/SafetyPreWarningDetailSearchPartialwebsite.js"));


            //一级安全评估查询脚本
            bundles.Add(new ScriptBundle("~/bundles/FirstLevelSafetyAssessmentReportList-website").Include(
                     "~/Scripts/FirstLevelSafetyAssessment/FirstLevelSafetyAssessmentReportList-website.js"));

            //报警数据查询
            bundles.Add(new ScriptBundle("~/bundles/AlarmDatasQuerySearchContentPartial-website").Include(
                     "~/Scripts/AlarmDatas/AlarmDatasQuery-SearchContentPartial-website.js"));
            bundles.Add(new ScriptBundle("~/bundles/AlermDatasQuerySearchPartial").Include(
                    "~/Scripts/AlarmDatas/AlermDatasQuerySearchPartial.website.js"));
                     
            //二级安全评估查询脚本
            bundles.Add(new ScriptBundle("~/bundles/SecondLevelSafetyAssessmentReportList-website").Include(
                     "~/Scripts/SafetyAssessmentReport/SecondLevelSafetyAssessmentReportList-website.js"));

            //专项安全评估查询脚本
            bundles.Add(new ScriptBundle("~/bundles/SpecialSafetyAssessmentReportList-website").Include(
                     "~/Scripts/SafetyAssessmentReport/SpecialSafetyAssessmentReportList-website.js"));

        }
    }
}
