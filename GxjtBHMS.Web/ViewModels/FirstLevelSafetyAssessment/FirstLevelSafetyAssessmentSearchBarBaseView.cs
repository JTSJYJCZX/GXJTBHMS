using System;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.FirstLevelSafetyAssessment
{
    public class FirstLevelSafetyAssessmentSearchBarBaseView
    {

        public DateTime Time { get; set; }      
        public FirstLevelSafetyAssessmentSearchBarBaseView()
        {
            Time = DateTime.Now;
        }
        public List<FirstLevelSafetyAssessmentViewModel> FirstLevelSafetyAssessmentViewModels { get; set; }
    }
}