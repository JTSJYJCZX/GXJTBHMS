using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Web.ViewModels.ThresholdValueSetting
{
    public class ThresholdValueSettingView
    {
        public ThresholdValueSettingView()
        {
            ThresholdValues = new List<ThresholdValueView>();
        }

        public IEnumerable<ThresholdValueView> ThresholdValues;
        public PaginatorModel PaginatorModel { get; set; }

    }
}