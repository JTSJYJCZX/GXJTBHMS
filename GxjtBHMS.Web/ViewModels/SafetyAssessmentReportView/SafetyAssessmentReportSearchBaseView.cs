using GxjtBHMS.Web.Models;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.SafetyAssessmentReportView
{
    public class SafetyAssessmentReportSearchBaseView
    {
        public int CurrentPageIndex { get; set; }

        public DateTime Time { get; set; }
        public SafetyAssessmentReportSearchBaseView()
        {
            CurrentPageIndex = WebConstants.FirstPageIndex;
            SafetyAssessmentReportViewModels = new List<SafetyAssessmentReportViewModel>();
        }
        public List<SafetyAssessmentReportViewModel> SafetyAssessmentReportViewModels { get; set; }

        public PaginatorModel PaginatorModel { get; set; }


    }
}