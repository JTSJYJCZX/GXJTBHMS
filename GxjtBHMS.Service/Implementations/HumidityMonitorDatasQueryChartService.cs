using System;
using System.Collections.Generic;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using GxjtBHMS.SqlServerDAL;
using System.Linq;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.IDAL;

namespace GxjtBHMS.Service.Implementations
{
    public class HumidityMonitorDatasQueryChartService : IMonitorDatasEigenvalueQueryChartService<HumidityTable>
    {
        readonly IHumidityDatasDAL _humidityDatasDAL;
        public HumidityMonitorDatasQueryChartService(IHumidityDatasDAL humidityDatasDAL)
        {
            _humidityDatasDAL = humidityDatasDAL;
        }

        public IEnumerable<ChartGroupDataModel> GetChartDataSourceBy(IList<Func<HumidityTable, bool>> ps)
        {
            var source = _humidityDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            var groupDatas = source.GroupBy(m => m.PointsNumber.Name);
            var datas = new List<ChartGroupDataModel>();
            foreach (var group in groupDatas)
            {
                //var models = group.OrderBy(m => m.Time).Select(m => new ChartDataModel { CreateDateTime = DateTimeHelper.FormatDateTime(m.Time), Value =m.Humidity});
                var unit = group.FirstOrDefault().PointsNumber.PointsPosition.TestType.Unit;
                //datas.Add(new ChartGroupDataModel { Models = models, CategoryName = group.Key, Unit = unit });
            }
            return datas;
        }
    }
}
