

using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Models.AbnormalThresholdValueSetting
{
    /// <summary>
    /// 阈值基类
    /// </summary>
    public class Abnormal_ThresholdValueTable : EntityBase<int>
    {
        
        public string TypeName { get; set; }
        /// <summary>
        /// 限值
        /// 上下限阈值
        /// </summary>              
        [DisplayName("上限阈值")]
        public double? MaxLevelThresholdValue { get; set; }
        [DisplayName("下限阈值")]
        public double? MinLevelThresholdValue { get; set; }
        
    }
}
