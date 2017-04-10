using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Models
{
    public class ThresholdGradeTable:EntityBase<int>
    {
        public string ThresholdGrade { get; set; }
        public string ThresholdColor { get; set; }
    }
}
