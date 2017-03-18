using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.ViewModels.ThresholdValueSetting
{
    public class QueryPointsNumberConditonView
    {
        public QueryPointsNumberConditonView()
        {
            CurrentPageIndex = WebConstants.FirstPageIndex;
        }

        public int CurrentPageIndex { get; set; }
        public string ContainsPointsNumber { get; set; }
    }
}