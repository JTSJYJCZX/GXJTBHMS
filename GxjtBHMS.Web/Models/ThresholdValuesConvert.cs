namespace GxjtBHMS.Web.Models
{
    static class ThresholdValuesConvert
    {
        public static ThresholdValueGroup ConvertForm(double?[] value)
        {
            var result = new ThresholdValueGroup();
            if (value != null && value.Length > 0)
            {
                result.PositiveStandardValueGroup.FirstLevelThresholdValue = value[0];
                result.PositiveStandardValueGroup.SecondLevelThresholdValue = value[1];
                result.NegativeStandardValueGroup.FirstLevelThresholdValue = value[2];
                result.NegativeStandardValueGroup.SecondLevelThresholdValue = value[3];
            }
            return result;
        }

        
    }
}