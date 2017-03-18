﻿using System;
using System.Collections.Generic;
using GxjtBHMS.Models;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.ViewModels.MonitoringDatas.MonitoringDatasCharts;
using GxjtBHMS.SqlServerDAL;
using System.Linq;
using GxjtBHMS.Infrastructure.Helpers;

namespace GxjtBHMS.Service.Implementations
{
    public class CableForceMonitorDatasQueryChartService : IMonitorDatasEigenvalueQueryChartService<CableForceTable>
    {
        readonly ICableForceDatasDAL _cableForceDatasDAL;
        public CableForceMonitorDatasQueryChartService(ICableForceDatasDAL  cableForceDatasDAL)
        {
            _cableForceDatasDAL = cableForceDatasDAL;
        }

        public IEnumerable<ChartGroupDataModel> GetChartDataSourceBy(IList<Func<CableForceTable, bool>> ps)
        {
            var source = _cableForceDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);
            var groupDatas = source.GroupBy(m => m.PointsNumber.Name);
            var datas = new List<ChartGroupDataModel>();
            foreach (var group in groupDatas)
            {
                //var models = group.OrderBy(m => m.Time).Select(m => new ChartDataModel { CreateDateTime = DateTimeHelper.FormatDateTime(m.Time), Value =m.CableForce});
                var unit = group.FirstOrDefault().PointsNumber.PointsPosition.TestType.Unit;
                //datas.Add(new ChartGroupDataModel { Models = models, CategoryName = group.Key, Unit = unit });
            }
            return datas;
        }
    }
}
