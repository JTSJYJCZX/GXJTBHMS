namespace GxjtBHMS.Web.Models
{
    static class ThresholdValuesConvert
    {
        public static ThresholdValueGroup ConvertForm(double?[] value)
        {
            var result = new ThresholdValueGroup();
            if (value != null && value.Length > 0)
            {
                result.PositiveStandardValueGroup.StandardValue = value[0];
                result.PositiveStandardValueGroup.FirstLevelThresholdValue = value[1];
                result.PositiveStandardValueGroup.SecondLevelThresholdValue = value[2];
                result.PositiveStandardValueGroup.ThirdLevelThresholdValue = value[3];

                result.NegativeStandardValueGroup.StandardValue = value[4];
                result.NegativeStandardValueGroup.FirstLevelThresholdValue = value[5];
                result.NegativeStandardValueGroup.SecondLevelThresholdValue = value[6];
                result.NegativeStandardValueGroup.ThirdLevelThresholdValue = value[7];
            }
            return result;
        }
    }
}