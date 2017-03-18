﻿using System;
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
    public class DisplaymentMonitorDatasQueryChartService : IMonitorDatasEigenvalueQueryChartService<DisplacementEigenvalueTable>
    {
        readonly IDisplaymentDatasEigenValueDAL  _displaymentDatasDAL;
        public DisplaymentMonitorDatasQueryChartService(IDisplaymentDatasEigenValueDAL  displaymentDatasDAL)
        {
            _displaymentDatasDAL = displaymentDatasDAL;
        }

        public IEnumerable<ChartGroupDataModel> GetChartDataSourceBy(IList<Func<DisplacementEigenvalueTable, bool>> ps)
        {
            var source = _displaymentDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
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