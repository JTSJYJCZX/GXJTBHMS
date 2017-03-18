using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GxjtBHMS.Models.RealTimeMonitoringDatas;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class RealTimeTemperatureDatasDAL : Repository<TemperatureTable, int>, IRealTimeTemperatureDatasDAL
    {
        public IEnumerable<RealTimeTemperatureModel> GetRealTimeTemperatures(int pointPositionId)
        {
            AddNewRealTimeTemperatureDatas(pointPositionId);//用于模拟实时监测数据，数据库中实时添加温度数据
            List<RealTimeTemperatureModel> result = GetRealTimeTemperatureDataByPositionId(pointPositionId);
            return result;
        }

        List<RealTimeTemperatureModel> GetRealTimeTemperatureDataByPositionId(int pointPositionId)
        {
            List<RealTimeTemperatureModel> result = new List<RealTimeTemperatureModel>();
            var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
            foreach (var item in pointsNumberId)
            {

                var sorce = FindBy(m => m.PointsNumberId == item, DALConstant.PointsNumberPointsPositionNavigationProperty).Last();
                RealTimeTemperatureModel realTimeModel = new RealTimeTemperatureModel()
                {
                    PointNumberId = sorce.PointsNumberId,
                    PointNumberName = sorce.PointsNumber.Name,
                    TemperatureDatas = sorce.Temperature
                };
                result.Add(realTimeModel);
            }
            return result;
        }

        int[] GetPointsNumberIdByPointsPositionId(int pointPositionId)
        {
            MonitoringPointsNumberDAL mpnDAL = new MonitoringPointsNumberDAL();
            return mpnDAL.FindBy(m => m.PointsPositionId == pointPositionId).Select(m => m.Id).ToArray();
        }

        /// <summary>
        /// 用于模拟实时监测数据，数据库中实时添加温度数据
        /// </summary>
        /// <param name="pointPositionId"></param>
        void AddNewRealTimeTemperatureDatas(int pointPositionId)
        {
            var random = new Random();
            var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
            foreach (var item in pointsNumberId)
            {
                TemperatureTable newTemperatureDatas = new TemperatureTable();
                if ((DateTime.Now.Second > 50) || (DateTime.Now.Second < 30 && DateTime.Now.Second > 20))
                {
                    newTemperatureDatas = new TemperatureTable()
                    {
                        PointsNumberId = item,
                        Temperature = random.Next(-11, 65),
                        Time = DateTime.Now
                    };
                }
                else
                {
                    newTemperatureDatas = new TemperatureTable()
                    {
                        PointsNumberId = item,
                        Temperature = random.Next(-8, 40),
                        Time = DateTime.Now
                    };
                }
                Add(newTemperatureDatas);
            }
        }
    }
}
