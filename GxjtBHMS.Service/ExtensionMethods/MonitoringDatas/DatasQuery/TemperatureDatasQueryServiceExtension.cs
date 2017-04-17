using GxjtBHMS.Models;
using GxjtBHMS.Service.ViewModels.DataQueryResult;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.DatasQuery
{
    static class TemperatureDatasQueryServiceExtension
    {
        public static IEnumerable<TemperatureDatasModel> ConvertToTemperatureDatasInfoViewList(this IEnumerable<Basic_TemperatureTable> source)
        {
            return source.Select(m => new TemperatureDatasModel
            {
                PointsNumber = m.PointsNumber.Name,
                Temperature = m.Temperature,
                Time = m.Time.ToString(),
             
            });
        }


    }
}

