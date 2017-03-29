using GxjtBHMS.Web.ViewModels.AbnormalThresholdValueSetting;
using System.Collections.Generic;

namespace GxjtBHMS.Web.ViewModels.AbnormalThresholdValue
{
    public class AbnormalThresholdValueSettingView
    {
        public AbnormalThresholdValueSettingView()
        {
            AbnormalThresholdValues = new List<AbnormalThresholdValueView>();
         }
        public IEnumerable<AbnormalThresholdValueView>AbnormalThresholdValues;
        public PaginatorModel PaginatorModel { get; set; }


    }
}