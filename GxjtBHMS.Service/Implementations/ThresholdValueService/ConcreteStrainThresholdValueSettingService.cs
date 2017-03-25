using System;
using GxjtBHMS.IDAL;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System.Linq;
using GxjtBHMS.Models.ThresholdValueSetting;
using System.Collections.Generic;
using GxjtBHMS.Infrastructure.Configuration;

namespace GxjtBHMS.Service.Implementations
{
    public class ConcreteStrainThresholdValueSettingService : ThresholdValueSettingServiceBase<ConcreteStrainThresholdValueTable>
    {
        public override ThresholdValueResponse GetThresholdValueListByPointsPosition(GetThresholdValueByPointsPositionSearchRequest req)
        {
            var resp = new ThresholdValueResponse();
            try
            {
                var source = QueryThresholdValueListByPointsPosition(req);
                var result = new List<ThresholdValueIncludeNegativeModel>();          
                foreach (var item in source)
                {
                    var resultItem = new ThresholdValueIncludeNegativeModel();
                    resultItem.PointsNumberId = item.PointsNumberId;
                    resultItem.PointsNumberName = item.PointsNumber.Name;
                    resultItem.PositiveFirstLevelThresholdValue = item.PositiveFirstLevelThresholdValue;
                    resultItem.PositiveSecondLevelThresholdValue = item.PositiveSecondLevelThresholdValue;
                    resultItem.NegativeFirstLevelThresholdValue = item.NegativeFirstLevelThresholdValue;
                    resultItem.NegativeSecondLevelThresholdValue = item.NegativeSecondLevelThresholdValue;
                    result.Add(resultItem);
                }
                if (HasNoSearchResult(result))
                {
                    resp.Message = "无记录！";
                }
                else
                {
                    resp.ThresholdValuesIncludeNegative = result;
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

        public override ThresholdValueResponse ModifyThresholdValue(ThresholdValueSettingRequest req)
        {
            var resp = new ThresholdValueResponse();
            try
            {
                var source = ModifyThresholdValueByPointsNumberId(req);
                foreach (var item in source)
                {
                    item.PositiveFirstLevelThresholdValue = req.PositiveFirstLevelThresholdValue;
                    item.PositiveSecondLevelThresholdValue = req.PositiveSecondLevelThresholdValue;
                    item.NegativeFirstLevelThresholdValue = req.NegativeFirstLevelThresholdValue;
                    item.NegativeSecondLevelThresholdValue = req.NegativeSecondLevelThresholdValue;
                }
                var thresholdValue = source.First();
                SaveThresholdValueByPointsNumberId(thresholdValue);
                
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