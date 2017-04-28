using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System;
using System.Collections.Generic;

namespace GxjtBHMS.Service
{
    public class WithoutNegativeThresholdValueSettingServiceBase<T>: ThresholdValueSettingServiceBase<T> where T :WithoutNegativeThresholdValueBase
    {
        const string PointsNumber_NavigationProperty = "PointsNumber";
        IThresholdValueSettingDAL<T> _thresholdValueSettingDAL;
        public WithoutNegativeThresholdValueSettingServiceBase()
        {
            _thresholdValueSettingDAL = new NinjectFactory()
                 .GetInstance<IThresholdValueSettingDAL<T>>();
        }
        
        public ThresholdValueWithoutNegativeResponse GetThresholdValueListByPointsPosition(GetThresholdValueByPointsPositionSearchRequest req)
        {
            var resp = new ThresholdValueWithoutNegativeResponse();
            try
            {
                var source = QueryThresholdValueListByPointsPosition(req);
                var result = new List<ThresholdValueWithoutNegativeModel>();
                foreach (var item in source)
                {
                    var resultItem = new ThresholdValueWithoutNegativeModel();
                    resultItem.PointsNumberId = item.PointsNumberId;
                    resultItem.PointsNumberName = item.PointsNumber.Name;
                    resultItem.PositiveFirstLevelThresholdValue = item.PositiveFirstLevelThresholdValue;
                    resultItem.PositiveSecondLevelThresholdValue = item.PositiveSecondLevelThresholdValue;
                    result.Add(resultItem);
                }
                if (HasNoSearchResult(result))
                {
                    resp.Message = "无记录！";
                }
                else
                {
                    resp.ThresholdValuesWithoutNegative = result;
                    resp.IsContainNegative = false;
                    resp.Succeed = true;
                }
            }
            catch (Exception ex)
            {
                resp.Message = "搜索阈值列表信息发生错误！";
                Log(ex);
            }
            return resp;
        }

        public ThresholdValueWithoutNegativeModel GetThresholdValueListByPointsNumber(GetThresholdValueByPointsPositionSearchRequest req)
        {
            var result = new ThresholdValueWithoutNegativeModel();
            try
            {
                var source = QueryThresholdValueListByPointsNumber(req);
                result.PointsNumberId = source.PointsNumberId;
                result.PointsNumberName = source.PointsNumber.Name;
                result.PositiveFirstLevelThresholdValue = source.PositiveFirstLevelThresholdValue;
                result.PositiveSecondLevelThresholdValue = source.PositiveSecondLevelThresholdValue;
                result.IsContainNegative = false;
            }
            catch (Exception ex)
            {
                Log(ex);
            }
            return result;
        }



        public ThresholdValueWithoutNegativeResponse ModifyThresholdValue(ThresholdValueSettingRequest req)
        {
            var resp = new ThresholdValueWithoutNegativeResponse();
            try
            {
                var thresholdValues = ModifyThresholdValueByPointsNumberId(req);
                thresholdValues.PositiveFirstLevelThresholdValue = req.PositiveFirstLevelThresholdValue;
                thresholdValues.PositiveSecondLevelThresholdValue = req.PositiveSecondLevelThresholdValue;
                SaveThresholdValueByPointsNumberId(thresholdValues);
                resp.Message = "保存成功！";
                resp.Succeed = true;
            }
            catch (Exception ex)
            {
                resp.Message = "阈值保存失败！";
                Log(ex);
            }
            return resp;
        }




    }
}
