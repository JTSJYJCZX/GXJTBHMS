using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service
{
    public class ContainNegativeThresholdValueSettingServiceBase<T>:ServiceBase where T :ContainNegativeThresholdValueBase
    {
        const string PointsNumber_NavigationProperty = "PointsNumber";
        IThresholdValueSettingDAL<T> _thresholdValueSettingDAL;
        public ContainNegativeThresholdValueSettingServiceBase()
        {
            _thresholdValueSettingDAL = new NinjectFactory()
                 .GetInstance<IThresholdValueSettingDAL<T>>();
        }
        
        public ThresholdValueIncludeNegativeResponse GetThresholdValueListByPointsPosition(GetThresholdValueByPointsPositionSearchRequest req)
        {
            var resp = new ThresholdValueIncludeNegativeResponse();
            try
            {
                var source = QueryThresholdValueListByPointsPosition(req);
                var result = new List<ThresholdValueContainNegativeModel>();
                foreach (var item in source)
                {
                    var resultItem = new ThresholdValueContainNegativeModel();
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
                    resp.ThresholdValueContainNegative = result;
                    resp.IsContainNegative = true;
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

        public ThresholdValueIncludeNegativeResponse ModifyThresholdValue(ThresholdValueSettingRequest req)
        {
            var resp = new ThresholdValueIncludeNegativeResponse();
            try
            {
                var thresholdValues = ModifyThresholdValueByPointsNumberId(req);
                thresholdValues.PositiveFirstLevelThresholdValue = req.PositiveFirstLevelThresholdValue;
                thresholdValues.PositiveSecondLevelThresholdValue = req.PositiveSecondLevelThresholdValue;
                thresholdValues.NegativeFirstLevelThresholdValue = req.NegativeFirstLevelThresholdValue;
                thresholdValues.NegativeSecondLevelThresholdValue = req.NegativeSecondLevelThresholdValue;
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
        
        public IEnumerable<T> QueryThresholdValueListByPointsPosition(GetThresholdValueByPointsPositionSearchRequest req)
        {
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            DealWithEqualPointsPosition(req, ps);
            return _thresholdValueSettingDAL.FindBy(ps, PointsNumber_NavigationProperty);
        }

        public T ModifyThresholdValueByPointsNumberId(ThresholdValueSettingRequest req)
        {
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            DealWithContainsPointsNumber(req, ps);
            return _thresholdValueSettingDAL.FindBy(ps, PointsNumber_NavigationProperty).SingleOrDefault();
        }

        public void SaveThresholdValueByPointsNumberId(T ThresholdValue)
        {
            _thresholdValueSettingDAL.Save(ThresholdValue);
        }

        void DealWithEqualPointsPosition(GetThresholdValueByPointsPositionSearchRequest req, IList<Func<T, bool>> ps)
        {
            if (req.PointsPositionId > 0)
            {
                ps.Add(m => m.PointsNumber.PointsPositionId == req.PointsPositionId);
            }
        }

        void DealWithContainsPointsNumber(ThresholdValueSettingRequest req, IList<Func<T, bool>> ps)
        {
            if (!string.IsNullOrEmpty(req.PointsNumber))
            {
                ps.Add(m => m.PointsNumber.Name.Contains(req.PointsNumber));
            }
        }

        protected bool HasNoSearchResult(IEnumerable<ThresholdValueContainNegativeModel> thresholdValues)
        {
            return thresholdValues.Count() == 0;
        }


    }
}
