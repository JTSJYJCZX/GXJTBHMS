using System;
using GxjtBHMS.IDAL;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Models;
using System.Collections.Generic;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using System.Linq;
using GxjtBHMS.Infrastructure.Helpers;
using GxjtBHMS.Models.MonitoringDatasTable;
using GxjtBHMS.Models.MonitoringDatasEigenvalueTable;

namespace GxjtBHMS.Service.Implementations
{
    class SteelArchStrainMonitorDatasQueryChartService : IMonitorDatasEigenvalueQueryChartService<SteelArchStrainEigenvalueTable>
    {
        readonly ISteelArchStrainDatasEigenValueDAL _strainDatasDAL;
        public SteelArchStrainMonitorDatasQueryChartService(ISteelArchStrainDatasEigenValueDAL strainDatasDAL)
        {
            _strainDatasDAL = strainDatasDAL;
        }

        public IEnumerable<ChartGroupDataModel> GetChartDataSourceBy(IList<Func<SteelArchStrainEigenvalueTable, bool>> ps)
        {
            var source = _strainDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            var groupDatas = source.GroupBy(m => m.PointsNumber.Name);
            var datas = new List<ChartGroupDataModel>();
            foreach (var group in groupDatas)
            {
                var models = group.OrderBy(m => m.Time).Select(m => new ChartDataModel { CreateDateTime = DateTimeHelper.FormatDateTime(m.Time), MaxValue = m.Max, MinValue = m.Min, AverageValue = m.Average });
                var unit = group.FirstOrDefault().PointsNumber.PointsPosition.TestType.Unit;
                datas.Add(new ChartGroupDataModel { Models = models, CategoryName = group.Key, Unit= unit });
            }
            return datas;
        }


    }
}
