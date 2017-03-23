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
    public class ConcreteStrainThresholdValueSettingService : ThresholdValueSettingServiceBase,IConcreteStrainThresholdValueSettingService
    {
        const string PointsNumber_NavigationProperty = "PointsNumber";
        IConcreteStrainThresholdValueSettingDAL _concreteStrainthresholdValueSettingDAL;
        public ConcreteStrainThresholdValueSettingService()
        {
           
        }
        public ConcreteStrainThresholdValueSettingService(IConcreteStrainThresholdValueSettingDAL concreteStrainthresholdValueSettingDAL)
        {
            _concreteStrainthresholdValueSettingDAL = concreteStrainthresholdValueSettingDAL;
        }

        public override ConcreteStrainThresholdValueResponse GetThresholdValueListByPointsPosition(GetThresholdValueByPointsPositionSearchRequest req)
        {
            throw new NotImplementedException();
        }

        void DealWithEqualPointsPosition(GetThresholdValueByPointsPositionSearchRequest req, IList<Func<ConcreteStrainThresholdValueTable, bool>> ps)
        {
            if (req.PointsPositionId > 0)
            {
                ps.Add(m => m.PointsNumber.PointsPositionId == req.PointsPositionId);
            }
        }

        ConcreteStrainThresholdValueResponse IConcreteStrainThresholdValueSettingService.GetThresholdValueListByPointsPosition(GetThresholdValueByPointsPositionSearchRequest req)
        {

            var resp = new ConcreteStrainThresholdValueResponse();
            IList<Func<ConcreteStrainThresholdValueTable, bool>> ps = new List<Func<ConcreteStrainThresholdValueTable, bool>>();
            DealWithEqualPointsPosition(req, ps);
            try
            {
                var thresholdValues = _concreteStrainthresholdValueSettingDAL.FindBy(ps, PointsNumber_NavigationProperty);
                if (HasNoSearchResult(thresholdValues))
                {
                    resp.Message = "无记录！";
                }
                else
                {
                    resp.ConcreteStrainThresholdValues = thresholdValues;
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



 
        bool HasNoSearchResult(IEnumerable<ConcreteStrainThresholdValueTable> thresholdValues)
        {
            return thresholdValues.Count() == 0;
        }

        ConcreteStrainThresholdValueResponse IConcreteStrainThresholdValueSettingService.ModifyStrainThresholdValue(StrainThresholdValueSettingRequest model)
        {
            var resp = new ConcreteStrainThresholdValueResponse();
            try
            {
                var ThresholdValue = _concreteStrainthresholdValueSettingDAL.FindBy(m => m.PointsNumberId == model.PointsNumberId).SingleOrDefault();
                ThresholdValue.PositiveFirstLevelThresholdValue = model.PositiveFirstLevelThresholdValue;
                ThresholdValue.PositiveSecondLevelThresholdValue = model.PositiveSecondLevelThresholdValue;
                ThresholdValue.NegativeFirstLevelThresholdValue = model.NegativeFirstLevelThresholdValue;
                ThresholdValue.NegativeSecondLevelThresholdValue = model.NegativeSecondLevelThresholdValue;
                _concreteStrainthresholdValueSettingDAL.Save(ThresholdValue);
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