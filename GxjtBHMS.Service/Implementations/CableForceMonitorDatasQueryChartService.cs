using System;
using System.Collections.Generic;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using GxjtBHMS.SqlServerDAL;
using System.Linq;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;

namespace GxjtBHMS.Service.Implementations
{
    public class CableForceMonitorDatasQueryChartService : IMonitorDatasEigenvalueQueryChartService<CableForceEigenvalueTable>
    {
        readonly ICableForceDatasEigenvalueDAL  _cableForceDatasDAL;
        public CableForceMonitorDatasQueryChartService(ICableForceDatasEigenvalueDAL   cableForceDatasDAL)
        {
            _cableForceDatasDAL = cableForceDatasDAL;
        }

        public IEnumerable<ChartGroupDataModel> GetChartDataSourceBy(IList<Func<CableForceEigenvalueTable, bool>> ps)
        {
            var source = _cableForceDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
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
