using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class ConcreteStrainRealTimeDatasDAL : Repository<ConcreteStrainTable, int>, IConcreteStrainRealTimeDatasDAL
    {
        public IEnumerable<ConcreteStrainTable> GetRealTimeStrains(int pointPositionId)
        {
            //AddNewRealTimeStrainDatas(pointPositionId);//用于模拟实时监测数据，数据库中实时添加应变数据
            List<ConcreteStrainTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<ConcreteStrainTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<ConcreteStrainTable> result = new List<ConcreteStrainTable>();
            var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
            foreach (var item in pointsNumberId)
            {
                string[] navigationProperty = { DALConstant.PointsNumberPointsPositionNavigationProperty, DALConstant.ThresholdGradeNavigationProperty };
                var sorce = FindBy(m => m.PointsNumberId == item, navigationProperty).Last();
                result.Add(sorce);
            }
            return result;
        }

        int[] GetPointsNumberIdByPointsPositionId(int pointPositionId)
        {
            MonitoringPointsNumberDAL mpnDAL = new MonitoringPointsNumberDAL();
            return mpnDAL.FindBy(m => m.PointsPositionId == pointPositionId).Select(m => m.Id).ToArray();
        }

        /// <summary>
        /// 实时添加应变数据，用于模拟实时监测
        /// </summary>
        /// <param name="pointPositionId"></param>
        //void AddNewRealTimeStrainDatas(int pointPositionId)
        //{
        //    var random = new Random();
        //    var pointsNumberId = GetPointsNumberIdByPointsPositionId(pointPositionId);
        //    foreach (var item in pointsNumberId)
        //    {
        //        ConcreteStrainTable newStrainDatas = new ConcreteStrainTable();
        //        if ((DateTime.Now.Second > 50) || (DateTime.Now.Second < 30 && DateTime.Now.Second > 20))
        //        {
        //            newStrainDatas = new ConcreteStrainTable()
        //            {
        //                PointsNumberId = item,
        //                Strain = random.Next(-105, 125),
        //                Time = DateTime.Now
        //            };
        //        }
        //        else
        //        {
        //            newStrainDatas = new ConcreteStrainTable()
        //            {
        //                PointsNumberId = item,
        //                Strain = random.Next(-60, 80),
        //                Time = DateTime.Now
        //            };
        //        }
        //        Add(newStrainDatas);
        //    }
        //}
    }
}
