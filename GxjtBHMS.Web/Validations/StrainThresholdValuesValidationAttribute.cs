using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using System;
using GxjtBHMS.Web.Models;

namespace GxjtBHMS.Web.Validations
{

    static class ThresholdValueSettingConstants
    {
        public const int PositiveThresholdValueMinValue = 0;
        public const int PositiveThresholdValueMaxValue = 10000;
        public const int NegativeThresholdValueMinValue = -10000;
        public const int NegativeThresholdValueMaxValue = 0;
    }

    enum ThresholdValueType
    {
        /// <summary>
        /// 正值
        /// </summary>
        Positive,
        /// <summary>
        /// 负值
        /// </summary>
        Negative,
    }

    abstract class ThresholdValuesValidationServiceBase
    {
        public abstract bool IsValid();
    }

    class PositiveStandardValueValidationService : ThresholdValuesValidationServiceBase
    {
        double _value;

        public PositiveStandardValueValidationService(double value)
        {
            _value = value;
        }

        public override bool IsValid()
        {
            return _value >= ThresholdValueSettingConstants.PositiveThresholdValueMinValue && _value <= ThresholdValueSettingConstants.PositiveThresholdValueMaxValue;
        }
    }

    class NegativeStandardValueValidationService : ThresholdValuesValidationServiceBase
    {
        double _value;

        public NegativeStandardValueValidationService(double value)
        {
            _value = value;
        }

        public override bool IsValid()
        {
            return _value >= ThresholdValueSettingConstants.NegativeThresholdValueMinValue && _value <= ThresholdValueSettingConstants.NegativeThresholdValueMaxValue;
        }
    }

    class ThresholdValuesValidationFactory
    {
        public static ThresholdValuesValidationServiceBase GetValidationService(ThresholdValueType type, double value)
        {

            switch (type)
            {
                case ThresholdValueType.Positive:
                    return new PositiveStandardValueValidationService(value);
                case ThresholdValueType.Negative:
                    return new NegativeStandardValueValidationService(value);
                default:
                    throw new ApplicationException("No StrainThresholdValuesValidationService");
            }
        }
    }

    class ThresholdValuesValidationAttribute : ValidationAttribute
    {
        public override bool IsValid(object value)
        {
            if (value == null)
                return false;
            var thresholdValues = value as double?[];
            var dict = ConvertToCategoriesDict(thresholdValues);//将可空double数组转化为两种类型的字典存储
            var returnVal = true;
            foreach (var key in dict.Keys)
            {//遍历字典键
                foreach (var item in dict[key])
                {
                    //便利字典值可空double数组
                    if (item.HasValue)
                    {//有值就验证该值是否合法
                        returnVal = ThresholdValuesValidationFactory
                     .GetValidationService(key, item.Value)
                     .IsValid();
                        if (!returnVal) break;//只要遇到非法的阈值就终止循环
                    }
                }
                if (!returnVal) break;//只要遇到非法的阈值就终止循环
            }
            return returnVal;
        }

        Dictionary<ThresholdValueType, double?[]> ConvertToCategoriesDict(double?[] thresholdValues)
        {
            var dict = new Dictionary<ThresholdValueType, double?[]>();
            var tg = ThresholdValuesConvert.ConvertForm(thresholdValues);
            AddPositiveValuesToDict(dict, tg.PositiveStandardValueGroup);
            AddNegativeValuesToDict(dict, tg.NegativeStandardValueGroup);
            return dict;
        }

        /// <summary>
        /// 添加正阈值到字典
        /// </summary>
        /// <param name="dict">字典</param>
        /// <param name="group">负值分组</param>
        void AddNegativeValuesToDict(Dictionary<ThresholdValueType, double?[]> dict, NegativeStandardValueGroup group)
        {
            dict.Add(ThresholdValueType.Negative, group.ToArray());//负阈值数据
        }

        void AddPositiveValuesToDict(Dictionary<ThresholdValueType, double?[]> dict, PositiveStandardValueGroup group)
        {
            dict.Add(ThresholdValueType.Positive, group.ToArray());//正阈值数据
        }

    }


    class AbnormalThresholdValuesValidationAttribute : ValidationAttribute
    {
        public override bool IsValid(object value)
        {
            if (value == null)
                return false;
            var thresholdValues = value as double?[];
            var returnVal = true;
            var maxValue = thresholdValues[0];
            for (int i = 0; i < thresholdValues.Length; i++)
            {
                if (!thresholdValues[i].HasValue)
                {//遍历数组是否有值
                    returnVal = false;
                }
                if (thresholdValues[i] >= maxValue && i > 0)
                {//遍历数组是否有下限值超过上限值的输入
                    returnVal = false;
                }
                if (!returnVal) break;//只要遇到非法的阈值就终止循环
            }
            return returnVal;
        }
    }
}