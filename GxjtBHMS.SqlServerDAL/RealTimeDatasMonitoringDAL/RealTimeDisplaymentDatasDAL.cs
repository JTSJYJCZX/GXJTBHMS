using GxjtBHMS.IDAL;
using GxjtBHMS.Models;
using GxjtBHMS.Models.RealTimeMonitoringDatas;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class RealTimeDisplaymentDatasDAL : Repository<DisplacementTable, int>, IRealTimeDisplaymentDatasDAL
    {
        public IEnumerable<RealTimeDisplaymentModel> GetRealTimeDisplayments(int pointPositionId)
        {
            AddNewRealTimeDisplaymentDatas(pointPositionId);//用于模拟实时监测数据，数据库中实时添加位移数据
            List<RealTimeDisplaymentModel> result = GetRealTimeDisplaymentDataByPositionId(pointPositionId);
            return result;
        }

        List<RealTimeDisplaymentModel> GetRealTimeDisplaymentDataByPositionId(int pointPositionId)
        {
            List<RealTimeDisplaymentModel> result = new List<RealTimeDisplaymentModel>();
            var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
            foreach (var item in pointsNumberId)
            {
                
                var sorce = FindBy(m => m.PointsNumberId == item, DALConstant.PointsNumberPointsPositionNavigationProperty).Last();
                RealTimeDisplaymentModel realTimeModel = new RealTimeDisplaymentModel()
                {
                    PointNumberId = sorce.PointsNumberId,
                    PointNumberName = sorce.PointsNumber.Name,
                    DisplaymentDatas = sorce.Displacement
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
        /// 实时添加位移数据，用于模拟实时监测
        /// </summary>
        /// <param name="pointPositionId"></param>
        void AddNewRealTimeDisplaymentDatas(int pointPositionId)
        {
            var random = new Random();
            var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
            foreach (var item in pointsNumberId)
            {
                DisplacementTable newDisplaymentDatas = new DisplacementTable();
                if ((DateTime.Now.Second > 50) || (DateTime.Now.Second < 30 && DateTime.Now.Second > 20))
                {
                    newDisplaymentDatas = new DisplacementTable()
                    {
                        PointsNumberId = item,
                        Displacement = random.Next(-35, 35),
                        Time = DateTime.Now
                    };
                }
                else
                {
                    newDisplaymentDatas = new DisplacementTable()
                    {
                        PointsNumberId = item,
                        Displacement = random.Next(-20, 20),
                        Time = DateTime.Now
                    };
                }
                Add(newDisplaymentDatas);
            }
        }


    }
}
