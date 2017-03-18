using GxjtBHMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GxjtBHMS.Service.ViewModels.DataQueryResult;
using GxjtBHMS.SqlServerDAL;
using MathNet.Numerics.Statistics;
using GxjtBHMS.Service.Interfaces;

namespace GxjtBHMS.Service.Implementations
{
    class CableForceMonitorDataQueryStatisticService : IMonitorDataQueryStatisticService<CableForceTable>
    {
        readonly ICableForceDatasDAL _cableForceDatasDAL;
        public CableForceMonitorDataQueryStatisticService(ICableForceDatasDAL cableForceDatasDAL)
        {
            _cableForceDatasDAL = cableForceDatasDAL;
        }
        public IList<ResultStatisticsModel> GetDatasStatisticBy(IList<Func<CableForceTable, bool>> ps)
        {
              var  cableForcesExcludePaging = _cableForceDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
                    var statisticGroupDatas = cableForcesExcludePaging.GroupBy(m => m.PointsNumber);//对未分页的数据按测点编号进行排序
                    return StatisticMethod(statisticGroupDatas);//计算查询数据的统计分析
        }
        IList<ResultStatisticsModel> StatisticMethod(IEnumerable<IGrouping<MonitoringPointsNumber, CableForceTable>> datas)
        {
            IList<ResultStatisticsModel> statisticResults = new List<ResultStatisticsModel>();
            foreach (var group in datas)
            {
                statisticResults.Add(new ResultStatisticsModel()
                {
                    MaxValue = group.Select(m => m.CableForce).Max(),//计算最大值
                    MinValue = group.Select(m => m.CableForce).Min(),//计算最小值
                    AverageValue = Math.Round(group.Select(m => m.CableForce).Average(), 3),//计算平均值
                    StandardDeviationValue = Math.Round(ArrayStatistics.StandardDeviation(group.Select(m => m.CableForce).ToArray()), 3),//计算标准差
                    PointsNumber = group.Key.Name
                });
            }
            return statisticResults;
        }
    }
}
