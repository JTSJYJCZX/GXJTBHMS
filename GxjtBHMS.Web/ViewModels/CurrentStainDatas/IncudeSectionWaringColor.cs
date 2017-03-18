using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GxjtBHMS.Web.ViewModels.CurrentStainDatas
{
    public class IncudeSectionWaringColor
    {
        public string SectionWarningColor { get; set; }
        public IEnumerable<RealTimeWarningStrainDataViewModel> WarningStrainData { get; set; }
    }
}