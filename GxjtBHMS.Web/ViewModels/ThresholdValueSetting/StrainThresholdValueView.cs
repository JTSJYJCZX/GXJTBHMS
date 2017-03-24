using GxjtBHMS.Web.Validations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace GxjtBHMS.Web.ViewModels.ThresholdValueSetting
{
    public class ThresholdValueView
    {
        public int TestTypeId { get; set; }
        public string PointsNumber { get; set; }
        public int PointsNumberId { get; set; } 

        #region MyRegion
        /// <summary>
        /// 正标准值
        /// 正的一二级阈值
        /// </summary>              
        [DisplayName("正一级阈值")]
        [Range(0.0, 10000.0, ErrorMessage = "{0}只能为0到10000之间的数值！")]
        public double? PositiveFirstLevelThresholdValue { get; set; }
        [DisplayName("正二级阈值")]
        [Range(0.0, 10000.0, ErrorMessage = "{0}只能为0到10000之间的数值！")]
        public double? PositiveSecondLevelThresholdValue { get; set; }
        /// <summary>
        /// 负标准值
        /// 负的一二级阈值
        /// </summary>

       
        [DisplayName("负一级阈值")]
        [Range(-10000.0, 0.0, ErrorMessage = "{0}只能为-10000到0之间的数值！")]
        public double? NegativeFirstLevelThresholdValue { get; set; }
        [DisplayName("负二级阈值")]
        [Range(-10000.0, 0.0, ErrorMessage = "{0}只能为-10000到0之间的数值！")]
        public double? NegativeSecondLevelThresholdValue { get; set; }       
        #endregion

        //public PaginatorModel PaginatorModel { get; set; }

        [DisplayName("测点阈值")]
        [StrainThresholdValuesValidation]
        public double?[] ThresholdValues { get; set; }
    }
}