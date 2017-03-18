using GxjtBHMS.Models;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Service.ViewModels.DataQueryResult;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.ExtensionMethods.MonitoringDatas.DatasQuery
{
    static class StrainDatasQueryServiceExtension
    {
        public static IEnumerable<StrainDatasModel> ConvertToStrainDatasInfoViewList(this IEnumerable<ConcreteStrainTable> source)
        {
            return source.Select(m => new StrainDatasModel
            {
                PointsNumber = m.PointsNumber.Name,
                Strain = m.Strain,
                Time = m.Time.ToString(),
                Temperature=m.Temperature
            });
        }


    }
}

