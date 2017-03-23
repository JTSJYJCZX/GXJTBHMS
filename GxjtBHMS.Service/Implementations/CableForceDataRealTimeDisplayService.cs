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
    public class CableForceDataRealTimeDisplayService : ServiceBase, ICableForceDataRealTimeDisplayService
    {
        IRealTimeCableForceDatasDAL _cfddDAL;
        IMonitoringPointsNumberDAL _mpnDAL;
        ICableForceThresholdValueGettingDAL _cftvDAL;
        IMonitoringPointsPositionDAL _mppDAL;
        public CableForceDataRealTimeDisplayService(IRealTimeCableForceDatasDAL cfddDAL, IMonitoringPointsNumberDAL mpnDAL, ICableForceThresholdValueGettingDAL cftvDAL, IMonitoringPointsPositionDAL mppDAL)
        {
            _cfddDAL = cfddDAL;
            _mpnDAL = mpnDAL;
            _cftvDAL = cftvDAL;
            _mppDAL = mppDAL;
        }

        public IEnumerable<RealTimeWarningDataModel> GetWarningCableForceDatasBy(int testTypeId)
        {
            List<RealTimeWarningDataModel> result = new List<RealTimeWarningDataModel>();
            try
            {
                var positionId = _mppDAL.GetModelsByTestTypeId(testTypeId).Select(m => m.Id).ToArray();
                foreach (var item in positionId)
                {
                    RealTimeWarningDataModel models = new RealTimeWarningDataModel();
                    var thresholdValue = _cftvDAL.GetCableForceThresholdValue(item).ToArray();
                    var source = _cfddDAL.GetRealTimeCableForces(item).ToArray();
                    for (int i = 0; i < source.Length; i++)
                    {
                        models.PointsNumber = source[i].PointNumberName;
                        models.CurrentData = source[i].CableForceDatas;
                        models.WarningGrade = GetPointWarningGrade(thresholdValue[i], source[i].CableForceDatas);
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

        WarningGrade GetPointWarningGrade(CableForceThresholdValueTable pointThresholdValue, double pointCurrentData)
        {
            if (pointCurrentData < pointThresholdValue.PositiveFirstLevelThresholdValue)
            {
                return WarningGrade.Health;
            }
            else if (pointCurrentData < pointThresholdValue.PositiveSecondLevelThresholdValue && pointCurrentData >= pointThresholdValue.PositiveFirstLevelThresholdValue)
            {
                return WarningGrade.FirstWarning;
            }
            //else if (pointCurrentData < pointThresholdValue.PositiveThirdLevelThresholdValue && pointCurrentData >= pointThresholdValue.PositiveSecondLevelThresholdValue)
            //{
            //    return WarningGrade.SecondWarning;
            //}
            //else if (pointCurrentData >= pointThresholdValue.PositiveThirdLevelThresholdValue)
            //{
            //    return WarningGrade.Danger;
            //}
            else
            {
                throw new ArgumentNullException("数据有误！");
            }
        }
    }
}
