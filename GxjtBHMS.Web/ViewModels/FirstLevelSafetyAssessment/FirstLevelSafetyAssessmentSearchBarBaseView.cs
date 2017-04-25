using GxjtBHMS.Web.Models;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.FirstLevelSafetyAssessment
{
    public class FirstLevelSafetyAssessmentSearchBarBaseView
    {
        public int CurrentPageIndex { get; set; }

        public DateTime Time { get; set; }
        public FirstLevelSafetyAssessmentSearchBarBaseView()
        {
            CurrentPageIndex = WebConstants.FirstPageIndex;
            FirstLevelSafetyAssessmentViewModels = new List<FirstLevelSafetyAssessmentViewModel>();
        }
        public List<FirstLevelSafetyAssessmentViewModel> FirstLevelSafetyAssessmentViewModels { get; set; }

        public PaginatorModel PaginatorModel { get; set; }


    }
}