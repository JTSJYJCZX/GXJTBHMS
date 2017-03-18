using System;
using System.Collections.Generic;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using GxjtBHMS.SqlServerDAL;
using System.Linq;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;

namespace GxjtBHMS.Service.Implementations
{
    public class HumidityMonitorDatasQueryChartService : IMonitorDatasEigenvalueQueryChartService<HumidityEigenvalueTable>
    {
        readonly IHumidityDatasEigenvalueDAL _humidityDatasDAL;
        public HumidityMonitorDatasQueryChartService(IHumidityDatasEigenvalueDAL humidityDatasDAL)
        {
            _humidityDatasDAL = humidityDatasDAL;
        }

        public IEnumerable<ChartGroupDataModel> GetChartDataSourceBy(IList<Func<HumidityEigenvalueTable, bool>> ps)
        {
            var source = _humidityDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            var groupDatas = source.GroupBy(m => m.PointsNumber.Name);
            var datas = new List<ChartGroupDataModel>();
            foreach (var group in groupDatas)
            {
                var models = group.OrderBy(m => m.Time).Select(m => new ChartDataModel { CreateDateTime = DateTimeHelper.FormatDateTime(m.Time), MaxValue = m.Max, MinValue = m.Min, AverageValue = m.Average });
                var unit = group.FirstOrDefault().PointsNumber.PointsPosition.TestType.Unit;
                datas.Add(new ChartGroupDataModel { Models = models, CategoryName = group.Key, Unit = unit });
            }
            return datas;
        }
    }
}
