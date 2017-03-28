using GxjtBHMS.Web.Validations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Web.ViewModels.AbormalThresholdValueSetting
{
    public class AbormalThresholdValueView
    {
        public int TypeId { get; set; }
        public string TypeName { get; set; }
        /// <summary>
        /// 限值
        /// 上下限阈值
        /// </summary>              
        [DisplayName("上限阈值")]
        public double? MaxLevelThresholdValue { get; set; }
        [DisplayName("下限阈值")]
        public double? MinLevelThresholdValue { get; set; }
        [DisplayName("测点阈值")]
        [ThresholdValuesValidation]
        public double?[] AbormalThresholdValues { get; set; }
    }
}