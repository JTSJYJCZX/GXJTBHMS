using System;

namespace GxjtBHMS.Web.ViewModels.ThresholdValueSetting
{
    public class ThresholdValueSearchBarBaseView
    {
        public int MornitoringTestTypeId { get; set; }
        public int MornitoringPointsPositionId { get; set; }
        public string MornitoringPointsNumber { get; set; }
        public int[] MornitoringPointsNumberIds { get; set; }
    }
}