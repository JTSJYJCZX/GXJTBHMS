using GxjtBHMS.Models;
using GxjtBHMS.Service.ViewModels.DataQueryResult;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.DatasQuery
{
    static class DisplaymentDatasQueryServiceExtension
    {
        public static IEnumerable<DisplaymentDatasModel> ConvertToDisplaymentDatasInfoViewList(this IEnumerable<DisplacementTable> source)
        {
            return source.Select(m => new DisplaymentDatasModel
            {
                PointsNumber = m.PointsNumber.Name,
                Displayment = m.Displacement,
                Time = m.Time.ToString()
            });
        }
    }
}

   