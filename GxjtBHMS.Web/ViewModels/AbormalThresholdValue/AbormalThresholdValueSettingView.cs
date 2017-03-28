using GxjtBHMS.Web.ViewModels.AbormalThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.AbormalThresholdValue
{
    public class AbormalThresholdValueSettingView
    {
        public AbormalThresholdValueSettingView()
        {
            AbormalThresholdValues = new List<AbormalThresholdValueView>();
         }
        public IEnumerable<AbormalThresholdValueView>AbormalThresholdValues;
        public PaginatorModel PaginatorModel { get; set; }

    }
}