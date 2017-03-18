using GxjtBHMS.Models;
using GxjtBHMS.Service.ViewModels.DataQueryResult;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.DatasQuery
{
    static class CableForceDatasQueryServiceExtension
    {
        public static IEnumerable<CableForceDatasModel> ConvertToDisplaymentDatasInfoViewList(this IEnumerable<CableForceTable> source)
        {
            return source.Select(m => new CableForceDatasModel
            {
                PointsNumber = m.PointsNumber.Name,
                CableForce = m.CableForce,
                Time = m.Time.ToString()
            });
        }
    }
}

   