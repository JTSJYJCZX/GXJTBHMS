using GxjtBHMS.Web.Validations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Web.ViewModels.ThresholdValueSetting
{
    public class StrainThresholdValueView
    {
        public string PointsNumber { get; set; }
        public int PointsNumberId { get; set; }
        #region MyRegion
        /// <summary>
        /// 正标准值
        /// 正的一二三级阈值
        /// </summary>
        [DisplayName("正标准值")]
        [Range(0.0, 10000.0, ErrorMessage = "{0}只能为0到10000之间的数值！")]
        public double? PositiveStandardValue { get; set; }
        [DisplayName("正一级阈值")]
        [Range(0.0, 10000.0, ErrorMessage = "{0}只能为0到10000之间的数值！")]
        public double? PositiveFirstLevelThresholdValue { get; set; }
        [DisplayName("正二级阈值")]
        [Range(0.0, 10000.0, ErrorMessage = "{0}只能为0到10000之间的数值！")]
        public double? PositiveSecondLevelThresholdValue { get; set; }
        [DisplayName("正三级阈值")]
        [Range(0.0, 10000.0, ErrorMessage = "{0}只能为0到10000之间的数值！")]
        public double? PositiveThirdLevelThresholdValue { get; set; }

        /// <summary>
        /// 负标准值
        /// 负的一二三级阈值
        /// </summary>

        [DisplayName("负标准值")]
        [Range(-10000.0, 0.0, ErrorMessage = "{0}只能为-10000到0之间的数值！")]
        public double? NegativeStandardValue { get; set; }
        [DisplayName("负一级阈值")]
        [Range(-10000.0, 0.0, ErrorMessage = "{0}只能为-10000到0之间的数值！")]
        public double? NegativeFirstLevelThresholdValue { get; set; }
        [DisplayName("负二级阈值")]
        [Range(-10000.0, 0.0, ErrorMessage = "{0}只能为-10000到0之间的数值！")]
        public double? NegativeSecondLevelThresholdValue { get; set; }
        [DisplayName("负二级阈值")]
        [Range(-10000.0, 0.0, ErrorMessage = "{0}只能为-10000到0之间的数值！")]
        public double? NegativeThirdLevelThresholdValue { get; set; } 
        #endregion

        public PaginatorModel PaginatorModel { get; set; }

        [DisplayName("测点阈值")]
        [StrainThresholdValuesValidation]
        public double?[] ThresholdValues { get; set; }
    }
}