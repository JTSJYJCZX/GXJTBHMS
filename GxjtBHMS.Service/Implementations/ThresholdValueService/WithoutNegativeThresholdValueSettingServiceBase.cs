using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.Interfaces;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GxjtBHMS.Service
{
    public class WithoutNegativeThresholdValueSettingServiceBase<T>:ServiceBase where T :WithoutNegativeThresholdValueBase
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

        protected bool HasNoSearchResult(IEnumerable<ThresholdValueWithoutNegativeModel> thresholdValues)
        {
            return thresholdValues.Count() == 0;
        }


    }
}
