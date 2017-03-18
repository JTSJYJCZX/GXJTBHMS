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
using GxjtBHMS.IDAL;

namespace GxjtBHMS.Service.Implementations
{
    class HumidityMonitorDataQueryStatisticService : IMonitorDataQueryStatisticService<HumidityTable>
    {
        readonly IHumidityDatasDAL _humidityDatasDAL;
        public HumidityMonitorDataQueryStatisticService(IHumidityDatasDAL humidityDatasDAL)
        {
            _humidityDatasDAL = humidityDatasDAL;
        }
        public IList<ResultStatisticsModel> GetDatasStatisticBy(IList<Func<HumidityTable, bool>> ps)
        {
              var humiditysExcludePaging = _humidityDatasDAL.FindBy(ps, ServiceConstant.PointsNumberPointsPositionNavigationProperty);//获取不分页的查询结果
                    var statisticGroupDatas = humiditysExcludePaging.GroupBy(m => m.PointsNumber);//对未分页的数据按测点编号进行排序
                    return StatisticMethod(statisticGroupDatas);//计算查询数据的统计分析
        }
        IList<ResultStatisticsModel> StatisticMethod(IEnumerable<IGrouping<MonitoringPointsNumber, HumidityTable>> datas)
        {
            IList<ResultStatisticsModel> statisticResults = new List<ResultStatisticsModel>();
            foreach (var group in datas)
            {
                statisticResults.Add(new ResultStatisticsModel()
                {
                    MaxValue = group.Select(m => m.Humidity).Max(),//计算最大值
                    MinValue = group.Select(m => m.Humidity).Min(),//计算最小值
                    AverageValue = Math.Round(group.Select(m => m.Humidity).Average(), 3),//计算平均值
                    StandardDeviationValue = Math.Round(ArrayStatistics.StandardDeviation(group.Select(m => m.Humidity).ToArray()), 3),//计算标准差
                    PointsNumber = group.Key.Name
                });
            }
            return statisticResults;
        }
    }
}
