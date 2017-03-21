using System;

namespace GxjtBHMS.Infrastructure.Helpers
{
    public static class DateTimeHelper
    {
        public static string FormatDateTime(this DateTime source)
        {
            return source.ToString("yyyy-MM-dd HH:mm:ss");
        }

        public static string FormatDateTimeToHour(this DateTime source)
        {
            return source.ToString("yyyy-MM-dd HH:00");
        }

        public static string FormatDate(this DateTime source)
        {
            return source.ToString("yyyy-MM-dd");
        }

        public static string FormatDateWithoutSymbol(this DateTime source)
        {
            return source.ToString("yyyyMMdd");
        }
    }
}
