using GxjtBHMS.IDAL;
using GxjtBHMS.Models.ThresholdValueSetting;
using GxjtBHMS.Service.Messaging;
using GxjtBHMS.Service.Messaging.ThresholdValueSetting;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GxjtBHMS.Service
{
    public class ThresholdValueSettingServiceBase<T> : ServiceBase where T : ThresholdValueConditionBase
    {
        const string PointsNumber_NavigationProperty = "PointsNumber";
        IThresholdValueSettingDAL<T> _thresholdValueSettingDAL;
        public ThresholdValueSettingServiceBase()
        {
            _thresholdValueSettingDAL = new NinjectFactory()
                 .GetInstance<IThresholdValueSettingDAL<T>>();
        }


        /// <summary>
        /// 通过测点编号查询阈值列表
        /// </summary>
        /// <param name="req"></param>
        /// <returns></returns>
        public T QueryThresholdValueListByPointsNumber(GetThresholdValueByPointsPositionSearchRequest req)
        {
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            DealWithEqualPointsNumber(req, ps);
            return _thresholdValueSettingDAL.FindBy(ps, PointsNumber_NavigationProperty).SingleOrDefault();
        }

        /// <summary>
        /// 通过测试截面查询阈值列表
        /// </summary>
        /// <param name="req"></param>
        /// <returns></returns>
        public IEnumerable<T> QueryThresholdValueListByPointsPosition(GetThresholdValueByPointsPositionSearchRequest req)
        {
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            DealWithEqualPointsPosition(req, ps);
            return _thresholdValueSettingDAL.FindBy(ps, PointsNumber_NavigationProperty);
        }

        /// <summary>
        /// 通过测点编号Id修改阈值
        /// </summary>
        /// <param name="req"></param>
        /// <returns></returns>
        public T ModifyThresholdValueByPointsNumberId(ThresholdValueSettingRequest req)
        {
            IList<Func<T, bool>> ps = new List<Func<T, bool>>();
            DealWithContainsPointsNumber(req, ps);
            return _thresholdValueSettingDAL.FindBy(ps, PointsNumber_NavigationProperty).SingleOrDefault();
        }

        /// <summary>
        /// 保存阈值
        /// </summary>
        /// <param name="ThresholdValue"></param>
        public void SaveThresholdValueByPointsNumberId(T ThresholdValue)
        {
            _thresholdValueSettingDAL.Save(ThresholdValue);
        }

        /// <summary>
        /// 处理测试截面查询条件
        /// </summary>
        /// <param name="req"></param>
        /// <param name="ps"></param>
        void DealWithEqualPointsPosition(GetThresholdValueByPointsPositionSearchRequest req, IList<Func<T, bool>> ps)
        {
            if (req.PointsPositionId > 0)
            {
                ps.Add(m => m.PointsNumber.PointsPositionId == req.PointsPositionId);
            }
        }
        /// <summary>
        /// 处理测点编号查询条件
        /// </summary>
        /// <param name="req"></param>
        /// <param name="ps"></param>
        void DealWithEqualPointsNumber(GetThresholdValueByPointsPositionSearchRequest req, IList<Func<T, bool>> ps)
        {
            if (!string.IsNullOrEmpty(req.PointsNumber))
            {
                ps.Add(m => m.PointsNumber.Name == req.PointsNumber);
            }
        }
        /// <summary>
        /// 处理测点编号包含字符查询条件
        /// </summary>
        /// <param name="req"></param>
        /// <param name="ps"></param>
        void DealWithContainsPointsNumber(ThresholdValueSettingRequest req, IList<Func<T, bool>> ps)
        {
            if (!string.IsNullOrEmpty(req.PointsNumber))
            {
                ps.Add(m => m.PointsNumber.Name.Contains(req.PointsNumber));
            }
        }
        /// <summary>
        /// 判断是否有记录
        /// </summary>
        /// <param name="thresholdValues"></param>
        /// <returns></returns>
        protected bool HasNoSearchResult(IEnumerable<ThresholdValueWithoutNegativeModel> thresholdValues)
        {
            return thresholdValues.Count() == 0;
        }


    }
}
