using System;
using System.Collections.Generic;
using GxjtBHMS.Models;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using GxjtBHMS.SqlServerDAL;
using System.Linq;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Service.Interfaces.MonitoringDatasQueryServiceInerfaces;

namespace GxjtBHMS.Service.Implementations
{
    public class MonitorDatasQueryChartService<T> : IMonitorDatasEigenvalueQueryChartService<T> where T: MonitoringDatasEigenvalueModel
    {
        readonly IMonitoringDatasEigenvalueDAL<T> _monitoringDatasDAL;
        public MonitorDatasQueryChartService(IMonitoringDatasEigenvalueDAL<T> monitoringDatasDAL)
        {
            _monitoringDatasDAL = monitoringDatasDAL;
        }

        public IEnumerable<ChartGroupDataModel> GetChartDataSourceBy(IList<Func<T, bool>> ps)
        {
            var source = _monitoringDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
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

        public long GetTotalResultCountBy(IList<Func<T, bool>> ps)
        {
            return _monitoringDatasDAL.GetCountByContains(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
        }
    }
}
