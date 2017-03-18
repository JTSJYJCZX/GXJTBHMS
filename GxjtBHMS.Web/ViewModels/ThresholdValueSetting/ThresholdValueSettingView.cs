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
            StrainThresholdValues = new List<StrainThresholdValueView>();
            //PaginatorModel = new PaginatorModel();
        }

        public IEnumerable<StrainThresholdValueView> StrainThresholdValues;
        public PaginatorModel PaginatorModel { get; set; }

    }
}