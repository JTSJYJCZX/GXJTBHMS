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
    public abstract class ThresholdValueSettingServiceBase<T> : ThresholdValueSettingServiceAbstractBase where T : ThresholdValueConditionBase
    {
        const string PointsNumber_NavigationProperty = "PointsNumber";
        IThresholdValueSettingDAL<T> _thresholdValueSettingDAL;
        public ThresholdValueSettingServiceBase()
        {
            _thresholdValueSettingDAL = new NinjectFactory()
                 .GetInstance<IThresholdValueSettingDAL<T>>();
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

        protected bool HasNoSearchResult(IEnumerable<ThresholdValueIncludeNegativeModel> thresholdValues)
        {
            return thresholdValues.Count() == 0;
        }


    }
}
