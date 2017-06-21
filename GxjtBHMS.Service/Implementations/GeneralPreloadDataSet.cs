using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Interfaces
{
    public class GeneralPreloadDataSet : IPreloadDataSet
    {
        readonly IMonitoringTestTypeService _mtts;
        readonly IMonitoringPointsNumberService _mpns;
        readonly IMonitoringPointsPositionService _mpps;
        public GeneralPreloadDataSet(IMonitoringTestTypeService mtts, IMonitoringPointsPositionService mpps, IMonitoringPointsNumberService mpns)
        {
            _mtts = mtts;
            _mpns = mpns;
            _mpps = mpps;
        }
        public IEnumerable<dynamic> Load(PreloadDataSetType type)
        {
            switch (type)
            {
                case PreloadDataSetType.MornitoringTestType:
                    return _mtts.GetAllTestType().Datas;
                case PreloadDataSetType.MonitoringPointsPositionType:
                    return _mpps.GetAllMonitoringPointsPosition().Datas;
                case PreloadDataSetType.MonitoringPointsNumberType:
                    return _mpns.GetAllMonitoringPointsNumber().Datas;
                default:
                    throw new ApplicationException("Invalid preload type");
            }
        }
    }
}