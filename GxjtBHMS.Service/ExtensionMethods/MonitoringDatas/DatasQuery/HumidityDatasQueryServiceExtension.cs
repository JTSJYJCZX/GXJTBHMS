using GxjtBHMS.Models;
using GxjtBHMS.Service.ViewModels.DataQueryResult;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.DatasQuery
{
    static class HumidityDatasQueryServiceExtension
    {
        public static IEnumerable<HumidityDatasModel> ConvertToHumidityDatasInfoViewList(this IEnumerable<Basic_HumidityTable> source)
        {
            return source.Select(m => new HumidityDatasModel
            {
                PointsNumber = m.PointsNumber.Name,
                Humidity = m.Humidity,
                Time = m.Time.ToString(),
             
            });
        }


    }
}

