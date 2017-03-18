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
    public class RealTimeHumidityDatasDAL : Repository<HumidityTable, int>, IRealTimeHumidityDatasDAL
    {
        public IEnumerable<RealTimeHumidityModel> GetRealTimeHumidities(int pointPositionId)
        {
            AddNewRealTimeHumidityDatas(pointPositionId);//用于模拟实时监测数据，数据库中实时添加湿度数据
            List<RealTimeHumidityModel> result = GetRealTimeHumidityDataByPositionId(pointPositionId);
            return result;
        }

        void AddNewRealTimeHumidityDatas(int pointPositionId)
        {
            var random = new Random();
            var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
            foreach (var item in pointsNumberId)
            {
                HumidityTable newHumidityDatas = new HumidityTable();
                if ((DateTime.Now.Second > 50) || (DateTime.Now.Second < 30 && DateTime.Now.Second > 20))
                {
                    newHumidityDatas = new HumidityTable()
                    {
                        PointsNumberId = item,
                        Humidity =random.Next(61,90),
                        Time = DateTime.Now
                    };
                }
                else
                {
                    newHumidityDatas = new HumidityTable()
                    {
                        PointsNumberId = item,
                        Humidity = random.Next(0, 58),
                        Time = DateTime.Now
                    };
                }
                Add(newHumidityDatas);
            }
        }

        List<RealTimeHumidityModel> GetRealTimeHumidityDataByPositionId(int pointPositionId)
        {
            List<RealTimeHumidityModel> result = new List<RealTimeHumidityModel>();
            var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
            foreach (var item in pointsNumberId)
            {

                var sorce = FindBy(m => m.PointsNumberId == item, DALConstant.PointsNumberPointsPositionNavigationProperty).Last();
                RealTimeHumidityModel realTimeModel = new RealTimeHumidityModel()
                {
                    PointNumberId = sorce.PointsNumberId,
                    PointNumberName = sorce.PointsNumber.Name,
                    HumidityDatas = sorce.Humidity
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
    }
}
