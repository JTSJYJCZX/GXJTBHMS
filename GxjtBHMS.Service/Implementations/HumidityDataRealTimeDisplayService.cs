using GxjtBHMS.Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.ExtensionMethods.GetEnumDescription;

namespace GxjtBHMS.Service.Implementations
{
    public class HumidityDataRealTimeDisplayService : ServiceBase, IHumidityDataRealTimeDisplayService
    {
        IRealTimeHumidityDatasDAL _hdDAL;
        IMonitoringPointsNumberDAL _mpnDAL;
        IHumidityThresholdValueGettingDAL _htvDAL;
        IMonitoringPointsPositionDAL _mppDAL;
        public HumidityDataRealTimeDisplayService(IRealTimeHumidityDatasDAL hdDAL, IMonitoringPointsNumberDAL mpnDAL, IHumidityThresholdValueGettingDAL htvDAL, IMonitoringPointsPositionDAL mppDAL)
        {
            _hdDAL = hdDAL;
            _mpnDAL = mpnDAL;
            _htvDAL = htvDAL;
            _mppDAL = mppDAL;
        }
        public IEnumerable<RealTimeWarningDataModel> GetWarningHumidityDatasBy(int testTypeId)
        {
            List<RealTimeWarningDataModel> result = new List<RealTimeWarningDataModel>();
            //try
            //{
            //    var positionId = _mppDAL.GetModelsByTestTypeId(testTypeId).Select(m => m.Id).ToArray();
            //    foreach (var item in positionId)
            //    {
            //        RealTimeWarningDataModel models = new RealTimeWarningDataModel();
            //        var thresholdValue = _htvDAL.GetHumidityThresholdValue(item).ToArray();
            //        var source = _hdDAL.GetRealTimeHumidities(item).ToArray();
            //        for (int i = 0; i < source.Length; i++)
            //        {
            //            models.PointsNumber = source[i].PointNumberName;
            //            models.CurrentData = source[i].HumidityDatas;
            //            models.WarningGrade = GetPointWarningGrade(thresholdValue[i], source[i].HumidityDatas);
            //            models.WarningColor = models.WarningGrade.FetchDescription();
            //            result.Add(models);
            //        }
            //    }
            //}
            //catch (Exception ex)
            //{
            //    Log(ex);
            //}
            return result;
        }

        //WarningGrade GetPointWarningGrade(HumidityThresholdValueTable pointThresholdValue, double pointCurrentData)
        //{
        //    if (IsHealth(pointThresholdValue, pointCurrentData))
        //    {
        //        return WarningGrade.Health;
        //    }
        //    else if (IsFirstWarning(pointThresholdValue, pointCurrentData))
        //    {
        //        return WarningGrade.FirstWarning;
        //    }
        //    else if (IsSecondWarning(pointThresholdValue, pointCurrentData))
        //    {
        //        return WarningGrade.SecondWarning;
        //    }
        //    else if (IsThirdWarning(pointThresholdValue, pointCurrentData))
        //    {
        //        return WarningGrade.Danger;
        //    }
        //    else
        //    {
        //        throw new ArgumentNullException("数据有误！");
        //    }
        //}
        //bool IsThirdWarning(HumidityThresholdValueTable pointThresholdValue, double pointCurrentData)
        //{
        //    return pointCurrentData >= pointThresholdValue.PositiveThirdLevelThresholdValue ;
        //}

        //bool IsSecondWarning(HumidityThresholdValueTable pointThresholdValue, double pointCurrentData)
        //{
        //    return (pointCurrentData < pointThresholdValue.PositiveThirdLevelThresholdValue && pointCurrentData >= pointThresholdValue.PositiveSecondLevelThresholdValue) ;
        //}

        //bool IsFirstWarning(HumidityThresholdValueTable pointThresholdValue, double pointCurrentData)
        //{
        //    return (pointCurrentData < pointThresholdValue.PositiveSecondLevelThresholdValue && pointCurrentData >= pointThresholdValue.PositiveFirstLevelThresholdValue) ;
        //}

        //bool IsHealth(HumidityThresholdValueTable pointThresholdValue, double pointCurrentData)
        //{
        //    return pointCurrentData < pointThresholdValue.PositiveFirstLevelThresholdValue ;
        //}
    }
}
