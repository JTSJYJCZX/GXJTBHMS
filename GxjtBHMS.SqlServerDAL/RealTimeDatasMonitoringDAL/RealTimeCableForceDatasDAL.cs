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
    public class RealTimeCableForceDatasDAL : Repository<CableForceTable, int>, IRealTimeCableForceDatasDAL
    {
        public IEnumerable<RealTimeCableForceModel> GetRealTimeCableForces(int pointPositionId)
        {
            AddNewRealTimeCableForceDatas(pointPositionId);//用于模拟实时监测数据，数据库中实时添加索力数据
            List<RealTimeCableForceModel> result = GetRealTimeCableForceDataByPositionId(pointPositionId);
            return result;
        }

        List<RealTimeCableForceModel> GetRealTimeCableForceDataByPositionId(int pointPositionId)
        {
            List<RealTimeCableForceModel> result = new List<RealTimeCableForceModel>();
            var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
            foreach (var item in pointsNumberId)
            {

                var sorce = FindBy(m => m.PointsNumberId == item, DALConstant.PointsNumberPointsPositionNavigationProperty).Last();
                RealTimeCableForceModel realTimeModel = new RealTimeCableForceModel()
                {
                    PointNumberId = sorce.PointsNumberId,
                    PointNumberName = sorce.PointsNumber.Name,
                    CableForceDatas  = sorce.CableForce
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
        /// 实时添加索力数据，用于模拟实时监测
        /// </summary>
        /// <param name="pointPositionId"></param>
        void AddNewRealTimeCableForceDatas(int pointPositionId)
        {
            var random = new Random();
            var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
            foreach (var item in pointsNumberId)
            {
                CableForceTable newCableForceDatas = new CableForceTable();
                if ((DateTime.Now.Second > 50) || (DateTime.Now.Second < 30 && DateTime.Now.Second > 20))
                {
                    newCableForceDatas = new CableForceTable()
                    {
                        PointsNumberId = item,
                        CableForce = random.Next(1500, 1760),
                        Time = DateTime.Now
                    };
                }
                else
                {
                    newCableForceDatas = new CableForceTable()
                    {
                        PointsNumberId = item,
                        CableForce = random.Next(1500, 2700),
                        Time = DateTime.Now
                    };
                }
                Add(newCableForceDatas);
            }
        }

    }
}
