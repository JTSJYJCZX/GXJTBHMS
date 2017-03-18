using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.ExtensionMethods.GetEnumDescription;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.ViewModels.RealTimeDatasDisplay;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service.Implementations
{
    public class TemperatureDataRealTimeDisplayService:ServiceBase,ITemperatureDataRealTimeDisplayService
    {
        IRealTimeTemperatureDatasDAL _tdDAL;
        IMonitoringPointsNumberDAL _mpnDAL;
        ITemperatureThresholdValueGettingDAL _ttvDAL;
        IMonitoringPointsPositionDAL _mppDAL;
        public TemperatureDataRealTimeDisplayService(IRealTimeTemperatureDatasDAL tdDAL,IMonitoringPointsNumberDAL mpnDAL, ITemperatureThresholdValueGettingDAL ttvDAL, IMonitoringPointsPositionDAL mppDAL)
        {
            _tdDAL = tdDAL;
            _mpnDAL = mpnDAL;
            _ttvDAL = ttvDAL;
            _mppDAL = mppDAL;
        }

        public IEnumerable<RealTimeWarningDataModel> GetWarningTemperatureDatasBy(int testTypeId)
        {
            List<RealTimeWarningDataModel> result = new List<RealTimeWarningDataModel>();
            try
            {
                var positionId = _mppDAL.GetModelsByTestTypeId(testTypeId).Select(m => m.Id).ToArray();
                foreach (var item in positionId)
                {
                    RealTimeWarningDataModel models = new RealTimeWarningDataModel();
                    var thresholdValue = _ttvDAL.GetTemperatureThresholdValue(item).ToArray();
                    var source = _tdDAL.GetRealTimeTemperatures(item).ToArray();
                    for (int i = 0; i < source.Length; i++)
                    {
                        models.PointsNumber = source[i].PointNumberName;
                        models.CurrentData = source[i].TemperatureDatas;
                        models.WarningGrade = GetPointWarningGrade(thresholdValue[i], source[i].TemperatureDatas);
                        models.WarningColor = models.WarningGrade.FetchDescription();
                        result.Add(models);
                    }
                }
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return result;
        }

        WarningGrade GetPointWarningGrade(TemperatureThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            if (IsHealth(pointThresholdValue, pointCurrentData))
            {
                return WarningGrade.Health;
            }
            else if (IsFirstWarning(pointThresholdValue, pointCurrentData))
            {
                return WarningGrade.FirstWarning;
            }
            else if (IsSecondWarning(pointThresholdValue, pointCurrentData))
            {
                return WarningGrade.SecondWarning;
            }
            else if (IsThirdWarning(pointThresholdValue, pointCurrentData))
            {
                return WarningGrade.Danger;
            }
            else
            {
                throw new ArgumentNullException("数据有误！");
            }
        }

        bool IsThirdWarning(TemperatureThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            return pointCurrentData >= pointThresholdValue.PositiveThirdLevelThresholdValue || pointCurrentData <= pointThresholdValue.NegativeThirdLevelThresholdValue;
        }

        bool IsSecondWarning(TemperatureThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            return (pointCurrentData < pointThresholdValue.PositiveThirdLevelThresholdValue && pointCurrentData >= pointThresholdValue.PositiveSecondLevelThresholdValue) || (pointCurrentData > pointThresholdValue.NegativeThirdLevelThresholdValue && pointCurrentData <= pointThresholdValue.NegativeSecondLevelThresholdValue);
        }

        bool IsFirstWarning(TemperatureThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            return (pointCurrentData < pointThresholdValue.PositiveSecondLevelThresholdValue && pointCurrentData >= pointThresholdValue.PositiveFirstLevelThresholdValue) || (pointCurrentData > pointThresholdValue.NegativeSecondLevelThresholdValue && pointCurrentData <= pointThresholdValue.NegativeFirstLevelThresholdValue);
        }

        bool IsHealth(TemperatureThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            return pointCurrentData < pointThresholdValue.PositiveFirstLevelThresholdValue && pointCurrentData > pointThresholdValue.NegativeFirstLevelThresholdValue;
        }
    }
}
