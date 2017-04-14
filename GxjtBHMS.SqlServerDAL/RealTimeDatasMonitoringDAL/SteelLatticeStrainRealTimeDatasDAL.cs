﻿using GxjtBHMS.IDAL;
using GxjtBHMS.Models.MonitoringDatasTable;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.SqlServerDAL.RealTimeDatasMonitoringDAL
{
    public class SteelLatticeStrainRealTimeDatasDAL : Repository<SteelLatticeStrainTable, int>,ISteelLatticeStrainRealTimeDatasDAL
    {
        public IEnumerable<SteelLatticeStrainTable> GetRealTimeStrains(int pointPositionId)
        {
            List<SteelLatticeStrainTable> result = GetRealTimeDataByPositionId(pointPositionId);
            return result;
        }

        List<SteelLatticeStrainTable> GetRealTimeDataByPositionId(int pointPositionId)
        {
            List<SteelLatticeStrainTable> result = new List<SteelLatticeStrainTable>();
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

    }
}
